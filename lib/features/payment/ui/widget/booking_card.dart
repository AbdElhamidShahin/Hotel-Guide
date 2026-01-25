import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                'https://t3.ftcdn.net/jpg/00/29/13/38/360_F_29133877_bfA2n7A3Q3W8IaV1ZCByWdG8qcZGLqep.jpg', // استبدلها برابط صورتك
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pyramids Gate Hotel",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D2D3F),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        "19 مارس 2026",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 13.sp, color: const Color(0xFF2D2D3F)),
                      children: [
                        const TextSpan(text: "يبدأ من "),
                        TextSpan(
                          text: "1000EGP",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                        ),
                        const TextSpan(text: " / الليلة"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. سهم الانتقال
            Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}