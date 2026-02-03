import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_calendar.dart';
import 'package:hotel_guide/features/payment/ui/widget/booking_card.dart';
import 'package:hotel_guide/features/payment/ui/widget/counter_row.dart';
import 'package:hotel_guide/features/payment/ui/widget/payment_summary_section.dart';
import 'package:hotel_guide/features/payment/ui/widget/price_section.dart';
import 'package:hotel_guide/features/payment/ui/widget/show_all_card_bottom_sheet.dart';
import 'package:hotel_guide/features/payment/ui/widget/show_all_wallet_bottom_sheet.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/router/routers.dart';
import '../../../core/theme/app_theme.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  // Prices
  final double pricePerNight = 1000;
  final double taxes = 500;
  final double services = 300;

  // Counters
  int rooms = 1;
  int adults = 2;
  int children = 1;

  // Payment
  String selectedPayment = 'wallet';
  DateTime focusedDay = DateTime.now();
  DateTime? rangeStart = DateTime.now();
  DateTime? rangeEnd = DateTime.now().add(const Duration(days: 1));

  int get totalDays => rangeStart != null && rangeEnd != null
      ? rangeEnd!.difference(rangeStart!).inDays + 1
      : 1;

  double get subTotal => pricePerNight * totalDays * rooms;
  double get totalPrice => subTotal + taxes + services;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(
        name: "الغرفه",
        onTap: () {
          context.go(routes.RoomDetailsPage);
        },
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

              SizedBox(height: 60.h),

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

              SizedBox(height: 80.h),

              _sectionTitle("حجوزاتي"),
              SizedBox(height: 15.h),
              const BookingCard(),

              SizedBox(height: 30.h),

              _sectionTitle("وسائل الدفع"),
              SizedBox(height: 15.h),

              PaymentTile(
                title: "المحفظة الإلكترونية",
                selected: selectedPayment == 'wallet',
                onTap: () {
                  setState(() => selectedPayment = 'wallet');
                  showAllWalletBottomSheet(context);
                },
                trailing: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: AppColors.ShadowPurple.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset("assets/icons/empty-wallet.svg"),
                ),
              ),

              SizedBox(height: 12.h),

              PaymentTile(
                title: "البطاقة البنكية",
                selected: selectedPayment == 'card',
                onTap: () {
                  setState(() => selectedPayment = 'card');
                  showAllCardBottomSheet(context);
                },

                trailing: Row(
                  children: [
                    SvgPicture.asset("assets/icons/MasterCard.svg"),
                    SizedBox(width: 8.w),
                    SvgPicture.asset("assets/icons/Visa.svg"),
                  ],
                ),
              ),

              SizedBox(height: 80.h),
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
}
