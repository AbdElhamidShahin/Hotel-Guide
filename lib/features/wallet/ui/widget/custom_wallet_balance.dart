import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomWalletBalance extends StatefulWidget {
  CustomWalletBalance({super.key});

  @override
  State<CustomWalletBalance> createState() => _CustomWalletBalanceState();
}

class _CustomWalletBalanceState extends State<CustomWalletBalance> {
  String selectedPayment = 'history';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: AppColors.ShadowPurple,
                //     borderRadius: BorderRadius.circular(50.r),
                //   ),
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.share_outlined,
                //       size: 28.sp,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.r),

                    border: Border.all(color: AppColors.colorText),
                  ),
                  child: Image.asset(
                    height: 100.h,
                    width: 100.w,
                    "assets/images/profile.png",
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              "Abdo Shahin",
              style: textStyle23SemiBoldBlack.copyWith(color: Colors.white),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 170,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.r),
                color: AppColors.ShadowPurple,
              ),
              child: Text(
                "ID  224476353",
                style: textStyle20BoldShadowPurple.copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.PurplePrimary,
                ),
                child: Column(
                  children: [
                    Text(
                      "الرصيد الحالي",
                      style: textStyle16RegularGray.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Text("33,000 EGP", style: textStyle36BoldWhite),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _CustomCoulmnWallet(
                          "assets/icons/refresh-circle.svg",
                          "سجل المعاملات",
                          selectedPayment == 'history',
                          () {
                            setState(() => selectedPayment = 'history');
                          },
                        ),
                        Container(
                          height: 32.h,
                          color: Colors.white,
                          width: 1.5,
                        ),
                        _CustomCoulmnWallet(
                          "assets/icons/money-recive.svg",
                          "الإسترداد",
                          selectedPayment == 'refund',
                          () {
                            setState(() => selectedPayment = 'refund');
                          },
                        ),
                        Container(
                          height: 32.h,
                          color: Colors.white,
                          width: 1.5,
                        ),
                        _CustomCoulmnWallet(
                          "assets/icons/empty-wallet-add.svg",
                          "شحن رصيد",
                          selectedPayment == 'topup',
                          () {
                            setState(() => selectedPayment = 'topup');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

GestureDetector _CustomCoulmnWallet(
  String image,
  String title,
  bool selected,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        SvgPicture.asset(
          image,
          color: selected ? AppColors.AccentsPurple : AppColors.white,
        ),

        SizedBox(height: 12.h),
        Text(
          title,
          style: textStyle16RegularGray.copyWith(
            color: selected ? AppColors.AccentsPurple : AppColors.white,
          ),
        ),
      ],
    ),
  );
}
