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
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final cs = Theme.of(context).colorScheme;
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  // surface = white in light, dark card in dark mode.
                  color: cs.surface,
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
                          style: TextStyle(
                            // onSurfaceVariant = secondary text, adapts in dark mode.
                            color: cs.onSurfaceVariant,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 90.h,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 55.r,
                    height: 55.r,
                    decoration: BoxDecoration(
                      // outline = themed border, visible in both modes.
                      border: Border.all(color: cs.outline, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      // onSurface = readable in both modes.
                      color: cs.onSurface,
                      size: 30.r,
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
}
