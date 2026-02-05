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

void showWalletBottomSheet(BuildContext context, BookingModel bookingData) {
  final bookingCubit = context.read<BookingCubit>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      // استخدمنا Context العادي هنا لسهولة التعامل
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // الهيدر
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

            // قائمة المحافظ (استخدمت BlocBuilder عشان التحديد يشتغل)
            BlocBuilder<BookingCubit, BookingStates>(
              bloc: bookingCubit, // ربطناه بالكيوبيت مباشرة
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

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  await bookingCubit.confirmBooking(finalBooking);

                  if (context.mounted) Navigator.pop(context);

                  if (bookingCubit.state is BookingSuccess) {
                    Navigator.pop(context);
                    context.go(routes.homeScreen);
                    showCustomSnackbar(
                      context,
                      ContentType.success,
                      'تم الحجز بنجاح ✅',
                      'تم خصم المبلغ من محفظتك',
                    );
                  } else if (bookingCubit.state is BookingError) {
                    final error = (bookingCubit.state as BookingError).message;
                    showCustomSnackbar(
                      context,
                      ContentType.failure,
                      'عفواً، رصيد محفظتك غير كافي لإتمام الحجز',
                      error,
                    );
                  }
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
                      "تأكيد دفع ${bookingData.totalPrice.toInt()} EGP",
                      style: textStyle20BoldShadowPurple.copyWith(
                        color: Colors.white,
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
  );
}
