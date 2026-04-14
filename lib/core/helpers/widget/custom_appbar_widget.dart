import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarWidget({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
      ),
      child: SizedBox(
        height: kToolbarHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              name,
              style: font22BoldPrimary.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),

            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 28.sp,
                ),
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
