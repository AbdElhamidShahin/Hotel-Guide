import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

void showAllCardBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _CardBottomSheetContent(),
  );
}

/// Extracted into a proper [StatefulWidget] — eliminates the [StatefulBuilder]
/// anti-pattern and gives the sheet its own clean state scope.
class _CardBottomSheetContent extends StatefulWidget {
  const _CardBottomSheetContent();

  @override
  State<_CardBottomSheetContent> createState() => _CardBottomSheetContentState();
}

class _CardBottomSheetContentState extends State<_CardBottomSheetContent> {
  String _selectedCard = 'master';

  void _handleConfirm() {
    showCustomSnackbar(
      context,
      ContentType.warning,
      'تنبيه',
      'عفواً، الدفع عن طريق البطاقة البنكية غير متاح حالياً. يرجى استخدام المحفظة الإلكترونية.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                Text(
                  'البطاقة البنكية',
                  style: textStyle20RegularPrimary.copyWith(
                    color: AppColors.black6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          _CardOptionTile(
            image: 'assets/icons/MasterCard.svg',
            title: 'Master Card',
            isSelected: _selectedCard == 'master',
            onTap: () => setState(() => _selectedCard = 'master'),
          ),
          SizedBox(height: 12.h),
          _CardOptionTile(
            image: 'assets/icons/Visa.svg',
            title: 'Visa',
            isSelected: _selectedCard == 'visa',
            onTap: () => setState(() => _selectedCard = 'visa'),
          ),
          SizedBox(height: 30.h),
          _ConfirmButton(onTap: _handleConfirm),
        ],
      ),
    );
  }
}

/// Proper named [StatelessWidget] — replacing the free function `CustomCardItem`
/// which violated Dart naming conventions (widgets must be classes, not functions,
/// and must start with a lowercase letter if they are functions).
class _CardOptionTile extends StatelessWidget {
  const _CardOptionTile({
    required this.image,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
              color: isSelected ? AppColors.Purple : Colors.transparent,
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
                  style:
                  textStyle16BoldWhite.copyWith(color: AppColors.primary),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey),
                    color: isSelected ? AppColors.primary : Colors.transparent,
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
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            'تأكيد الدفع',
            style: textStyle20BoldShadowPurple.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}