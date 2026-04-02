import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/network/model/booking_model.dart';

void showCardsBottomSheet({
  required BuildContext context,
  required bool isPaymentMode, // هذا المتغير سيحدد شكل الصفحة
  BookingModel? booking,       // يكون مطلوب فقط في حالة الدفع
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (context) {
      // سنستخدم StatefulBuilder هنا إذا أردت تغيير حالة الاختيار (Checkbox) داخل الـ BottomSheet
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. العنوان (يتغير حسب الحالة)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                    Text(
                      isPaymentMode ? 'الدفع بالبطاقة' : 'بطاقاتي المحفوظة',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                SizedBox(height: 20.h),

                // 2. قائمة البطاقات (تظهر في الحالتين)
                _buildCardItem(
                  title: "Master Card (**** 1234)",
                  isSelected: true,
                  icon: "assets/icons/mastercard.png",
                  showCheckbox: isPaymentMode, // لا تظهر الـ Checkbox في حالة الإدارة
                  onTap: () {
                    if (isPaymentMode) {
                      // منطق اختيار البطاقة للدفع
                    }
                  },
                ),

                _buildCardItem(
                  title: "Visa (**** 5678)",
                  isSelected: false,
                  icon: "assets/icons/visa.png",
                  showCheckbox: isPaymentMode,
                  onTap: () {},
                ),

                // 3. زر إضافة بطاقة جديدة (يظهر في الحالتين)
                _buildAddNewCard(context, isPaymentMode),

                // 4. زر التأكيد (يظهر فقط في حالة الدفع)
                if (isPaymentMode) ...[
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () {
                      // هنا تضع منطق الدفع باستخدام Stripe
                      print("جاري الدفع لمبلغ: ${booking?.totalAmount}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E2E3E),
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

                // إضافة مساحة في الأسفل لتجنب تداخل الأزرار مع شريط التنقل في بعض الهواتف
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
  required String title,
  required bool isSelected,
  required String icon,
  required bool showCheckbox, // معامل جديد للتحكم في ظهور علامة الصح
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: isSelected && showCheckbox ? const Color(0xFF5E5E7E) : Colors.transparent),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.r)],
      ),
      child: Row(
        children: [
          // لو معندكش صور حالياً ممكن تستخدم Icon بدالها
          const Icon(Icons.credit_card, color: Colors.blueGrey),
          SizedBox(width: 15.w),
          Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
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
    onTap: () {
      // هنا تستدعي Stripe Payment Sheet لعمل SetupIntent (حفظ فقط)
      // أو PaymentIntent مع اختيار حفظ البطاقة
    },
    child: Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.grey),
          ),
          SizedBox(width: 15.w),
          Text('إضافة بطاقة جديدة', style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    ),
  );
}