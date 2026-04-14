import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/network/model/booking_model.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../notification/logic/notificatin_logic.dart';
import '../../logic/booking_cubit.dart';
import '../../logic/booking_state.dart';
import 'custom_wallet_item.dart';

// Helper: هل رسالة الخطأ تعني رصيد ناقص؟
bool _isInsufficientBalance(String message) {
  return message.contains('رصيد') ||
      message.contains('غير كافٍ') ||
      message.contains('insufficient') ||
      message.contains('balance');
}

void showWalletBottomSheet(
    BuildContext parentContext,
    BookingModel bookingData,
    ) {
  final bookingCubit = parentContext.read<BookingCubit>();

  showModalBottomSheet(
    context: parentContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BlocListener<BookingCubit, BookingStates>(
        bloc: bookingCubit,
        listener: (context, state) async {
          if (state is BookingLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
              const Center(child: CircularProgressIndicator()),
            );
          } else if (state is BookingSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); // close loading
            Navigator.of(context).pop(); // close bottom sheet

            // ✅ Repo already saved the notification to DB.
            // Here we only refresh the local in-memory NotificationCubit
            // so the bell icon updates immediately without a re-fetch.
            getIt<NotificationCubit>().fetchNotifications();

            context.push(
              routes.bookingResult,
              extra: {
                'isSuccess': true,
                'paymentMethod': 'المحفظة الإلكترونية',
              },
            );
            showCustomSnackbar(
              parentContext,
              ContentType.success,
              'تم الحجز بنجاح ✅',
              'تم خصم ${bookingData.totalAmount.toInt()} EGP من محفظتك',
            );
          } else if (state is BookingError) {
            Navigator.of(context, rootNavigator: true).pop(); // close loading

            // ✅ Repo already saved the failure notification to DB for card path.
            // Refresh local list so the bell updates immediately.
            getIt<NotificationCubit>().fetchNotifications();

            // ── هل الخطأ بسبب رصيد ناقص؟ ──
            final bool isBalanceError = _isInsufficientBalance(state.message);

            if (isBalanceError) {
              // نفضل في نفس الـ BottomSheet ونعرض رسالة واضحة للمستخدم
              showCustomSnackbar(
                context,
                ContentType.failure,
                'رصيد غير كافٍ 💳',
                'رصيد محفظتك لا يكفي لإتمام الحجز.\nالمطلوب: ${bookingData.totalAmount.toInt()} EGP',
              );
            } else {
              // خطأ عام → أغلق الـ BottomSheet وروح لصفحة النتيجة
              Navigator.of(context).pop();
              context.push(
                routes.bookingResult,
                extra: {'isSuccess': false, 'errorMessage': state.message},
              );
              showCustomSnackbar(
                parentContext,
                ContentType.failure,
                'عفواً، فشل الحجز',
                state.message,
              );
            }
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
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
                      style: font20RegularPrimary.copyWith(
                        color: AppColors.darkBackground,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              BlocBuilder<BookingCubit, BookingStates>(
                bloc: bookingCubit,
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomWalletItem(
                        image: 'assets/images/Orange.png',
                        title: 'أورنج كاش',
                        cashBack: 'كاش باك 5%',
                        selected: bookingCubit.selectedWallet == 'orange',
                        onTap: () => bookingCubit.changeWallet('orange'),
                      ),
                      SizedBox(height: 12.h),
                      CustomWalletItem(
                        image: 'assets/images/logo/logo-light.png',
                        title: 'محفظة AQUA',
                        cashBack: 'كاش باك 10%',
                        selected: bookingCubit.selectedWallet == "AQUA",
                        onTap: () => bookingCubit.changeWallet('AQUA'),
                      ),
                    ],
                  );
                },
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: GestureDetector(
                  onTap: () async {
                    if (bookingCubit.selectedWallet != 'AQUA') {
                      showCustomSnackbar(
                        context,
                        ContentType.warning,
                        'تنبيه',
                        'يرجى اختيار محفظة AQUA',
                      );
                      return;
                    }

                    final user = Supabase.instance.client.auth.currentUser;
                    if (user == null) return;

                    final finalBooking = bookingData.copyWith(
                      userId: user.id,
                      paymentMethod: bookingCubit.selectedWallet,
                    );

                    await bookingCubit.confirmBooking(finalBooking);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        "تأكيد دفع ${bookingData.totalAmount.toInt()} EGP",
                        style: font20BoldShadowPurple.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}