import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/network/model/booking_model.dart';
import 'package:hotel_guide/core/theme/colors.dart';

void showCardsBottomSheet({
  required BuildContext context,
  required bool isPaymentMode,
  BookingModel? booking,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text(
                      isPaymentMode ? 'الدفع بالبطاقة' : 'بطاقاتي المحفوظة',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                SizedBox(height: 20.h),

                _buildCardItem(
                  context: context,
                  title: "Master Card (**** 1234)",
                  isSelected: true,
                  icon: "assets/icons/mastercard.png",
                  showCheckbox: isPaymentMode,
                  onTap: () {
                    if (isPaymentMode) {}
                  },
                ),

                _buildCardItem(
                  context: context,
                  title: "Visa (**** 5678)",
                  isSelected: false,
                  icon: "assets/icons/visa.png",
                  showCheckbox: isPaymentMode,
                  onTap: () {},
                ),

                _buildAddNewCard(context, isPaymentMode),

                if (isPaymentMode) ...[
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () {
                      print("جاري الدفع لمبلغ: ${booking?.totalAmount}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: Size(double.infinity, 55.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'تأكيد الدفع',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCardItem({
  required BuildContext context,
  required String title,
  required bool isSelected,
  required String icon,
  required bool showCheckbox,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isSelected && showCheckbox
              ? const Color(0xFF5E5E7E)
              : Theme.of(context).colorScheme.outline,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5.r)],
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card, color: Theme.of(context).colorScheme.onSurfaceVariant),
          SizedBox(width: 15.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          if (showCheckbox)
            Icon(
              isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
              color: isSelected ? const Color(0xFF5E5E7E) : Colors.grey,
            ),
        ],
      ),
    ),
  );
}

Widget _buildAddNewCard(BuildContext context, bool isPaymentMode) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          SizedBox(width: 15.w),
          Text(
            'إضافة بطاقة جديدة',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    ),
  );
}