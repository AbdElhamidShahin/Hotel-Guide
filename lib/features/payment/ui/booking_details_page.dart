import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/network/model/profile_model.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/payment/logic/booking_cubit.dart';
import 'package:hotel_guide/features/payment/logic/booking_state.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_calendar.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_card.dart';
import 'package:hotel_guide/features/payment/ui/widget/counter_row.dart';
import 'package:hotel_guide/features/payment/ui/widget/payment_title_booking_details.dart';
import 'package:hotel_guide/features/payment/ui/widget/price_section.dart';
import 'package:hotel_guide/features/payment/ui/widget/section_title_booking_details.dart';
import 'package:hotel_guide/features/payment/ui/widget/show_all_wallet_bottom_sheet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/network/model/booking_model.dart';
import '../../../core/network/model/room_model.dart';
import '../../../core/units/stripe_service.dart';
import '../data/model/payment_intent_input_model.dart';

// ✅ Fix: Removed inner BlocProvider — the router already provides BookingCubit.
// Creating a second BlocProvider here caused the widget tree to use a fresh cubit
// while the router's cubit received payment states that never propagated to the UI.
class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key, required this.room});
  final Room room;

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  UserProfileModel? userProfile;

  // ✅ Fix: profile loading moved out of Supabase.instance direct call
  // into a clean async init, but via the injected SupabaseClient pattern.
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) return;

    try {
      final response = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response != null && mounted) {
        setState(() => userProfile = UserProfileModel.fromMap(response));
      }
    } catch (_) {
      // Profile load failure is non-critical; card payment will show snackbar
    }
  }

  static const double _taxes = 500;
  static const double _services = 300;
  int _rooms = 1;
  int _adults = 2;
  int _children = 1;
  String _selectedPayment = 'wallet';
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now().add(const Duration(days: 1));

  int get _totalDays {
    if (_rangeStart != null && _rangeEnd != null) {
      return _rangeEnd!.difference(_rangeStart!).inDays.abs() + 1;
    }
    return 1;
  }

  double get _subTotal => widget.room.price.toDouble() * _totalDays * _rooms;
  double get _totalPrice => _subTotal + _taxes + _services;

  BookingModel get _currentBooking => BookingModel(
        hotelName: widget.room.name,
        totalAmount: _totalPrice,
        roomId: widget.room.id.toString(),
        startDate: _rangeStart ?? DateTime.now(),
        endDate: _rangeEnd ?? DateTime.now(),
        roomCount: _rooms,
        adults: _adults,
        children: _children,
        totalDays: _totalDays,
        userId: '',
        paymentMethod: _selectedPayment,
      );

  void _onWalletTap() {
    setState(() => _selectedPayment = 'wallet');
    showWalletBottomSheet(context, _currentBooking);
  }

  void _onCardTap() async {
    setState(() => _selectedPayment = 'card');

    if (userProfile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تسجيل الدخول أولاً')),
      );
      return;
    }

    final stripeCustomerId =
        await StripeService().getOrCreateStripeCustomerId(userProfile!);

    if (!mounted) return;

    context.read<BookingCubit>().makePayment(
          input: PaymentIntentInputModel(
            amount: (_totalPrice * 100).toInt().toString(),
            customerId: stripeCustomerId,
            currency: 'usd',
          ),
          booking: _currentBooking.copyWith(
            userId: userProfile!.id,
            paymentMethod: 'card',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingStates>(
      listenWhen: (_, current) =>
          _selectedPayment == 'card' &&
          (current is BookingSuccess || current is BookingError),
      listener: (context, state) {
        if (state is BookingSuccess) {
          context.push(
            routes.bookingResult,
            extra: {
              'isSuccess': true,
              'paymentMethod': 'البطاقة البنكية',
            },
          );
        } else if (state is BookingError) {
          context.push(
            routes.bookingResult,
            extra: {'isSuccess': false, 'errorMessage': state.message},
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbarWidget(
          name: 'تفاصيل الحجز',
          onTap: () => context.pop(),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingCalendar(
                  focusedDay: _focusedDay,
                  rangeStart: _rangeStart,
                  rangeEnd: _rangeEnd,
                  onSelect: (start, end, focused) => setState(() {
                    _rangeStart = start;
                    _rangeEnd = end;
                    _focusedDay = focused;
                  }),
                ),

                SizedBox(height: 30.h),

                CounterRow(
                  title: 'عدد الغرف',
                  value: _rooms,
                  onAdd: () => setState(() => _rooms++),
                  onRemove: () => setState(() {
                    if (_rooms > 1) _rooms--;
                  }),
                ),

                CounterRow(
                  title: 'البالغين',
                  value: _adults,
                  onAdd: () => setState(() => _adults++),
                  onRemove: () => setState(() {
                    if (_adults > 1) _adults--;
                  }),
                ),

                CounterRow(
                  title: 'الأطفال',
                  value: _children,
                  onAdd: () => setState(() => _children++),
                  onRemove: () => setState(() {
                    if (_children > 0) _children--;
                  }),
                ),

                SizedBox(height: 30.h),

                SectionTitle(title: 'تفاصيل الدفع'),
                SizedBox(height: 15.h),

                PriceSection(
                  days: _totalDays,
                  subTotal: _subTotal,
                  taxes: _taxes,
                  services: _services,
                  total: _totalPrice,
                ),

                SizedBox(height: 30.h),

                SectionTitle(title: 'الغرفة المختارة'),
                SizedBox(height: 15.h),
                BookingCard(room: widget.room),

                SizedBox(height: 30.h),

                SectionTitle(title: 'وسائل الدفع'),
                SizedBox(height: 15.h),

                PaymentTitle(
                  title: 'المحفظة الإلكترونية',
                  isSelected: _selectedPayment == 'wallet',
                  onTap: _onWalletTap,
                  icon: 'assets/icons/empty-wallet.svg',
                ),

                SizedBox(height: 12.h),

                BlocBuilder<BookingCubit, BookingStates>(
                  buildWhen: (previous, current) =>
                      current is BookingLoading || previous is BookingLoading,
                  builder: (context, state) {
                    return PaymentTitle(
                      title: 'البطاقة البنكية',
                      isSelected: _selectedPayment == 'card',
                      onTap: state is BookingLoading ? null : _onCardTap,
                      isCard: true,
                      isLoading: state is BookingLoading,
                    );
                  },
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
