import 'package:flutter/material.dart';


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
            child: Row(textDirection: TextDirection.rtl,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        "عرض جديد متاح الآن!",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w800, // Bold
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 6),

                      // The Horizontal Divider Line
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),

                      const SizedBox(height: 8),

                      // Body Text
                      const Expanded(
                        child: Text(
                          "فندق The Nile Ritz-Carlton أطلق خصمًا خاصًا لفترة محدودة — احجز الآن قبل انتهاء العرض!",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            height: 1.4, // Line height for readability
                            color: Colors.grey, // Grey color as in image
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 3, // Allow multiple lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Time Footer
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            Icons.access_time, // Clock icon
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "اليوم 14:35",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
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