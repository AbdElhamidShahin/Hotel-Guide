import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/payment/logic/booking_cubit.dart';
import 'package:hotel_guide/features/payment/logic/booking_state.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_calendar.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_card.dart';
import 'package:hotel_guide/features/payment/ui/widget/counter_row.dart';
import 'package:hotel_guide/features/payment/ui/widget/price_section.dart';
import 'package:hotel_guide/features/payment/ui/widget/show_all_wallet_bottom_sheet.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/network/model/booking_model.dart';
import '../../../core/network/model/room_model.dart';
import '../../../core/theme/app_theme.dart';
import '../data/model/payment_intent_input_model.dart';

/// [BlocProvider] is hoisted to the top of this widget so [BookingCubit]
/// is available to the entire page — not recreated per tile rebuild.
class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCubit>(
      // GetIt provides a fresh Factory instance per navigation.
      create: (_) => GetIt.I<BookingCubit>(),
      child: _BookingDetailsView(room: room),
    );
  }
}

class _BookingDetailsView extends StatefulWidget {
  const _BookingDetailsView({required this.room});
  final Room room;

  @override
  State<_BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<_BookingDetailsView> {
  // ── Constants ──────────────────────────────────────────────────────────────
  static const double _taxes = 500;
  static const double _services = 300;

  // ── Mutable UI state ───────────────────────────────────────────────────────
  int _rooms = 1;
  int _adults = 2;
  int _children = 1;
  String _selectedPayment = 'wallet';
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now().add(const Duration(days: 1));

  // ── Computed properties (no business logic in setState callbacks) ──────────
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
    userId: '', // Filled by BookingRepoImpl from the auth session.
    paymentMethod: _selectedPayment,
  );

  // ── Helpers ────────────────────────────────────────────────────────────────

  void _onWalletTap() {
    setState(() => _selectedPayment = 'wallet');
    showWalletBottomSheet(context, _currentBooking);
  }

  void _onCardTap() {
    setState(() => _selectedPayment = 'card');
    context.read<BookingCubit>().makePayment(
      input: PaymentIntentInputModel(
        amount: (_totalPrice * 100).toInt().toString(),
        currency: 'usd',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingStates>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          context.go(routes.homeScreen);
        } else if (state is BookingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
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

                _SectionTitle(title: 'تفاصيل الدفع'),
                SizedBox(height: 15.h),

                PriceSection(
                  days: _totalDays,
                  subTotal: _subTotal,
                  taxes: _taxes,
                  services: _services,
                  total: _totalPrice,
                ),

                SizedBox(height: 30.h),

                _SectionTitle(title: 'الغرفة المختارة'),
                SizedBox(height: 15.h),
                BookingCard(room: widget.room),

                SizedBox(height: 30.h),

                _SectionTitle(title: 'وسائل الدفع'),
                SizedBox(height: 15.h),

                _PaymentTile(
                  title: 'المحفظة الإلكترونية',
                  isSelected: _selectedPayment == 'wallet',
                  onTap: _onWalletTap,
                  icon: 'assets/icons/empty-wallet.svg',
                ),

                SizedBox(height: 12.h),

                // BlocBuilder is scoped to only this tile so rebuilds are
                // minimal — it reads the already-provided BookingCubit.
                BlocBuilder<BookingCubit, BookingStates>(
                  buildWhen: (_, s) =>
                      s is BookingLoading ||
                      s is BookingError ||
                      s is BookingSuccess,
                  builder: (context, state) {
                    return _PaymentTile(
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

// ── Extracted widgets ──────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle20BoldShadowPurple.copyWith(color: AppColors.black6),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.isCard = false,
    this.isLoading = false,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? icon;
  final bool isCard;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _RadioIndicator(isSelected: isSelected),
            SizedBox(width: 12.w),
            Text(
              title,
              style: textStyle16RegularGray.copyWith(color: Colors.black),
            ),
            const Spacer(),
            if (isLoading)
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            else if (isCard)
              Row(
                children: [
                  SvgPicture.asset('assets/icons/MasterCard.svg', width: 30.w),
                  SizedBox(width: 8.w),
                  SvgPicture.asset('assets/icons/Visa.svg', width: 30.w),
                ],
              )
            else if (icon != null)
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.ShadowPurple.withOpacity(0.1),
                ),
                child: SvgPicture.asset(icon!, width: 20.w),
              ),
          ],
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary),
        color: isSelected ? AppColors.primary : Colors.transparent,
      ),
      child: isSelected
          ? Icon(Icons.check, size: 12.r, color: Colors.white)
          : null,
    );
  }
}
