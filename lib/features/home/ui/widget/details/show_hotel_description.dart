import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_name_details.dart';

void showHotelDescription(
  BuildContext context,
  String description,
  String name,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,showDragHandle: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            const Spacer(flex: 1),

            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
              ),
              child: Column(
                children: [
                  CustomNameDetails(name: name),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        description,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Color(0xFF535367),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 100,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 55,
                    height: 55,

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      );
    },
  );
}
