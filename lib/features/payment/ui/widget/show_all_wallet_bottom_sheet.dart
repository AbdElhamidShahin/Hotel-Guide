import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import 'custom_wallet_item.dart';

void showAllWalletBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      String selectedWallet = 'orange';

      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.go(routes.BookingDetailsPage);
                        },
                        icon: Icon(Icons.close),
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
                SizedBox(height: 30.h),
                CustomWalletItem(
                  image: 'assets/images/Orange.png',
                  title: 'أورنج كاش',
                  cashBack: 'كاش باك 5% من المبلغ',
                  selected: selectedWallet == 'orange',
                  onTap: () {
                    setState(() => selectedWallet = 'orange');
                  },
                ),
                SizedBox(height: 12.h),
                CustomWalletItem(
                  image: 'assets/images/logo/logo-light.png',
                  title: 'محفظة AQUA',
                  cashBack: 'كاش باك 10% من المبلغ',
                  selected: selectedWallet == "AQUA",
                  onTap: () {
                    setState(() => selectedWallet = 'AQUA');
                  },
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    context.go(routes.BookingDetailsPage);
                    showCustomSnackbar(
                      context,
                      ContentType.success,
                      'تم الدفع بنجاح ✅',
                      '',
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        "تأكيد الدفع",
                        style: textStyle20BoldShadowPurple.copyWith(
                          color: Colors.white,
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
    },
  );
}
