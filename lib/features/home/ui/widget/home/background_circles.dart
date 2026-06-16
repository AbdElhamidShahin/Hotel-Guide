import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/colors.dart';

/// Decorative circles used inside the primary-colour AppBar banner.
/// The circle colour is always SlateBlueLight — it sits on AppColors.primary
/// and must stay consistent regardless of theme mode.
class BackgroundCircle extends StatelessWidget {
  const BackgroundCircle({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: 190.r,
        height: 190.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Intentionally static — always on AppColors.primary background.
          color: AppColors.SlateBlueLight,
        ),
      ),
    );
  }
}
