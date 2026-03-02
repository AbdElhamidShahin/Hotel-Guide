import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';

import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

void showAllCardBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      String selectedCard = 'master';

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
                        onPressed: () => Navigator.pop(context),

                        icon: Icon(Icons.close),
                      ),
                      Text(
                        "البطاقة البنكية",
                        style: textStyle20RegularPrimary.copyWith(
                          color: AppColors.black6,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomCardItem(
                  "assets/icons/MasterCard.svg",
                  "Master Card",
                  selectedCard == 'master',
                  () {
                    setState(() => selectedCard = 'master');
                  },
                ),
                SizedBox(height: 12.h),
                CustomCardItem(
                  "assets/icons/Visa.svg",
                  "Visa",
                  selectedCard == 'visa',
                  () {
                    setState(() => selectedCard = 'visa');
                  },
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    showCustomSnackbar(
                      context,
                      ContentType.warning,
                      'تنبيه',
                      'عفواً، الدفع عن طريق البطاقه البنكيه غير متاح حالياً. يرجى استخدام محفظة الالكترونيه.',
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

Padding CustomCardItem(
  final String image,
  final String title,
  final bool selected,
  final VoidCallback onTap,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.Purple : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              SvgPicture.asset(image),
              SizedBox(width: 20.w),

              Text(
                title,
                style: textStyle16BoldWhite.copyWith(color: AppColors.primary),
              ),
              const Spacer(),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey),
                  color: selected ? AppColors.primary : Colors.transparent,
                ),
                child: Icon(Icons.done, color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
