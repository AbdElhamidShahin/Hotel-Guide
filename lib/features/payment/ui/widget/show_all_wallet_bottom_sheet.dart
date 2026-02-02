import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/network/model/booking.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../logic/booking_cubit.dart';
import '../../logic/booking_state.dart';
import 'custom_wallet_item.dart';

void showAllWalletBottomSheet({
  required BuildContext context,
  required String hotelName,
  required BookingCubit bookingCubit,
  required double totalPrice,
  required String roomId,
  required DateTime startDate,
  required DateTime endDate,
  required int rooms,
  required int adults,
  required int children,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (modalContext) {
      String selectedWallet = 'orange';

      return BlocProvider.value(
        value: bookingCubit,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                children: [
                  // Header القسم العلوي
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                        Text(
                          "المحفظة الإلكترونية",
                          style: textStyle20RegularPrimary.copyWith(
                            color: AppColors.black6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // خيارات المحافظ
                  CustomWalletItem(
                    image: 'assets/images/Orange.png',
                    title: 'أورنج كاش',
                    cashBack: 'كاش باك 5% من المبلغ',
                    selected: selectedWallet == 'orange',
                    onTap: () => setState(() => selectedWallet = 'orange'),
                  ),
                  SizedBox(height: 12.h),
                  CustomWalletItem(
                    image: 'assets/images/logo/logo-light.png',
                    title: 'محفظة AQUA',
                    cashBack: 'كاش باك 10% من المبلغ',
                    selected: selectedWallet == "AQUA",
                    onTap: () => setState(() => selectedWallet = 'AQUA'),
                  ),

                  const Spacer(),

                  // منطقة الـ Listener والزرار
                  BlocListener<BookingCubit, BookingStates>(
                    listener: (context, state) {
                      if (state is BookingSuccess) {
                        showCustomSnackbar(
                          context,
                          ContentType.success,
                          'تم الحجز بنجاح!',
                          'تم خصم المبلغ وتأكيد حجزك في $hotelName',
                        );
                        Navigator.pop(context); // إغلاق الـ Bottom Sheet
                        context.go(routes.homeScreen); // التوجه للرئيسية
                      } else if (state is BookingError) {
                        showCustomSnackbar(
                          context,
                          ContentType.failure,
                          'عفواً!',
                          state.message,
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: GestureDetector(
                        onTap: () {print("🚀 [UI] Starting Booking Process...");
                        print("📍 Hotel: $hotelName | Price: $totalPrice");
                        print("📅 Dates: $startDate to $endDate");
                          final user = Supabase.instance.client.auth.currentUser;
                          if (user == null) {
                            showCustomSnackbar(context, ContentType.failure, "خطأ", "يجب تسجيل الدخول");
                            return;
                          }
                          print("🚀 [UI] Starting Booking Process...");
                          print("📍 Hotel: $hotelName | Price: $totalPrice");
                          print("📅 Dates: $startDate to $endDate");
                          // إنشاء الموديل بالبيانات الحقيقية
                          final booking = BookingModel(
                            roomId: roomId,
                            userId: user.id,
                            hotelName: hotelName,
                            startDate: startDate,
                            endDate: endDate,
                            totalPrice: totalPrice,
                            paymentMethod: selectedWallet,
                            roomCount: rooms,
                            adults: adults,
                            children: children,
                            totalDays: endDate.difference(startDate).inDays,
                          );

                          // استدعاء الحجز من الكيوبيت
                          context.read<BookingCubit>().confirmBooking(booking);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 55.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: BlocBuilder<BookingCubit, BookingStates>(
                              builder: (context, state) {
                                if (state is BookingLoading) {
                                  return const CircularProgressIndicator(color: Colors.white);
                                }
                                return Text(
                                  "تأكيد الدفع ${totalPrice.toInt()} EGP",
                                  style: textStyle20BoldShadowPurple.copyWith(
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}