import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomItemNotification extends StatelessWidget {
  const CustomItemNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 184,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/1686f7773fafd4ad2711763e02dd037e6522c12a.jpg",
                    width: 148,
                    height: 172,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 148,
                      height: 172,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        "عرض جديد متاح الآن!",
                        textDirection: TextDirection.rtl,
                        style: textStyle18BoldGray.copyWith(
                          color: AppColors.black4,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black.withOpacity(0.1),
                      ),

                      const SizedBox(height: 6),

                      // Body Text
                      Expanded(
                        child: Text(
                          "فندق The Nile Ritz-Carlton أطلق خصمًا خاصًا لفترة محدودة — احجز الآن قبل انتهاء العرض!",
                          textDirection: TextDirection.rtl,
                          style: textStyle15MediumGray.copyWith(
                            color: AppColors.black.withOpacity(0.43),

                            fontSize: 14,
                          ),
                          maxLines: 3, // Allow multiple lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Time Footer
                      Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          Icon(
                            Icons.access_time, // Clock icon
                            size: 24,
                            color: Colors.black.withOpacity(0.55),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "اليوم 14:35",
                            textDirection: TextDirection.rtl,
                            style: textStyle12BoldBlack.copyWith(
                              color: Color(0xFF8B8E918C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
