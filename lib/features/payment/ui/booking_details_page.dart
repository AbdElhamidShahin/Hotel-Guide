import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/payment/data/model/payment_intent_input_model.dart';
import 'package:hotel_guide/features/payment/data/payment_repo/payment_repo_impl.dart';
import 'package:hotel_guide/features/payment/logic/card_cubit/payment_cubit.dart';
import 'package:hotel_guide/features/payment/logic/card_cubit/payment_state.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_calendar.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_card.dart';
import 'package:hotel_guide/features/payment/ui/widget/counter_row.dart';
import 'package:hotel_guide/features/payment/ui/widget/price_section.dart';
import 'package:hotel_guide/features/payment/ui/widget/show_all_card_bottom_sheet.dart';
import 'package:hotel_guide/features/payment/ui/widget/show_all_wallet_bottom_sheet.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/network/model/booking_model.dart';
import '../../../core/network/model/room_model.dart';
import '../../../core/theme/app_theme.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key, required this.room});
  final Room room;

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final double taxes = 500;
  final double services = 300;
  int rooms = 1;
  int adults = 2;
  int children = 1;

  String selectedPayment = 'wallet';
  DateTime focusedDay = DateTime.now();
  DateTime? rangeStart = DateTime.now();
  DateTime? rangeEnd = DateTime.now().add(const Duration(days: 1));

  late double pricePerNight;

  @override
  void initState() {
    super.initState();
    pricePerNight = widget.room.price.toDouble();
  }

  int get totalDays {
    if (rangeStart != null && rangeEnd != null) {
      return rangeEnd!.difference(rangeStart!).inDays + 1;
    }
    return 1;
  }

  double get subTotal => pricePerNight * totalDays * rooms;
  double get totalPrice => subTotal + taxes + services;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(
        name: "تفاصيل الحجز",
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
                focusedDay: focusedDay,
                rangeStart: rangeStart,
                rangeEnd: rangeEnd,
                onSelect: (start, end, focused) {
                  setState(() {
                    rangeStart = start;
                    rangeEnd = end;
                    focusedDay = focused;
                  });
                },
              ),

              SizedBox(height: 30.h),

              CounterRow(
                title: "عدد الغرف",
                value: rooms,
                onAdd: () => setState(() => rooms++),
                onRemove: () => setState(() {
                  if (rooms > 1) rooms--;
                }),
              ),

              CounterRow(
                title: "البالغين",
                value: adults,
                onAdd: () => setState(() => adults++),
                onRemove: () => setState(() {
                  if (adults > 1) adults--;
                }),
              ),

              CounterRow(
                title: "الأطفال",
                value: children,
                onAdd: () => setState(() => children++),
                onRemove: () => setState(() {
                  if (children > 0) children--;
                }),
              ),

              SizedBox(height: 30.h),

              _sectionTitle("تفاصيل الدفع"),
              SizedBox(height: 15.h),

              PriceSection(
                days: totalDays,
                subTotal: subTotal,
                taxes: taxes,
                services: services,
                total: totalPrice,
              ),

              SizedBox(height: 30.h),

              _sectionTitle("الغرفة المختارة"),
              SizedBox(height: 15.h),
              BookingCard(room: widget.room),

              SizedBox(height: 30.h),

              _sectionTitle("وسائل الدفع"),
              SizedBox(height: 15.h),
              _buildPaymentTile(
                title: "المحفظة الإلكترونية",
                isSelected: selectedPayment == 'wallet',

                onTap: () {
                  setState(() => selectedPayment = 'wallet');

                  final bookingInfo = BookingModel(
                    hotelName: widget.room.name,
                    totalAmount: totalPrice,
                    roomId: widget.room.id.toString(),
                    startDate: rangeStart ?? DateTime.now(),
                    endDate: rangeEnd ?? DateTime.now(),
                    roomCount: rooms,
                    adults: adults,
                    children: children,
                    totalDays: totalDays,
                    userId: '',
                    paymentMethod: 'wallet',
                  );

                  showWalletBottomSheet(context, bookingInfo);
                },
                icon: "assets/icons/empty-wallet.svg",
                  isLoading: state is PaymentLoadingState ? true : false,
                  ,
              ),
              SizedBox(height: 12.h),

              BlocProvider(
                create: (BuildContext context) =>
                    PaymentCubit(PaymentRepoImpl()),
                child: BlocConsumer<PaymentCubit, PaymentState>(
                  builder: (BuildContext context, PaymentState state) {
                    _buildPaymentTile(
                      title: "البطاقة البنكية",
                      isSelected: selectedPayment == 'card',
                      onTap: () {
                        setState(() => selectedPayment = 'card');
                        showAllCardBottomSheet(context);
                        PaymentIntentInputModel paymentIntentInputModel =
                            PaymentIntentInputModel(
                              amount: BookingModel.totalPrice,
                              currency: "EGP",
                            );
                      },
                      isLoading: state is PaymentLoadingState ? true : false,

                      isCard: true,
                    );
                  },
                  listener: (BuildContext context, PaymentState state) {
                    if (state is PaymentSuccessState) {
                      context.pop();
                    }
                    if (state is PaymentErrorState) {
                      Navigator.of(context).pop();
                      SnackBar snackBar = SnackBar(content: Text(state.error));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: textStyle20BoldShadowPurple.copyWith(color: AppColors.black6),
    );
  }

  Widget _buildPaymentTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    String? icon,
    bool isCard = false,
    required bool isLoading,

  }) {
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
            Container(
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
            ),
            SizedBox(width: 12.w),


            isLoading
                ? CircularProgressIndicator()
                : Text(
              title,
              style: textStyle16RegularGray.copyWith(color: Colors.black),
            ),

            const Spacer(),
            if (isCard)
              Row(
                children: [
                  SvgPicture.asset("assets/icons/MasterCard.svg", width: 30.w),
                  SizedBox(width: 8.w),
                  SvgPicture.asset("assets/icons/Visa.svg", width: 30.w),
                ],
              )
            else if (icon != null)
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.ShadowPurple.withOpacity(0.1),
                ),
                child: SvgPicture.asset(icon, width: 20.w),
              ),
          ],
        ),
      ),
    );
  }
}
