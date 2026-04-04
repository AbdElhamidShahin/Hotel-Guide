import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/colors.dart';
class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [

          TextField(
            controller: controller,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'ما نوع الفندق الذي تبحث عنه؟ دعني أساعدك',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14.sp,
              ),
              hintTextDirection: TextDirection.rtl,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(60.w, 12.h, 20.w, 12.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
            ),
          ),

          Positioned(
            left: -2,
            child: GestureDetector(
              onTap: isLoading ? null : onSend,
              child: Container(
                margin: EdgeInsets.all(4.w),
                height: 48.h,
                width: 48.w,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : SvgPicture.asset(
                    "assets/icons/send.svg",
                    height: 24.h,
                    width: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}