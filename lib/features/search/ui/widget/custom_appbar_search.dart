import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class CustomAppbarSearch extends StatelessWidget {
  const CustomAppbarSearch({
    super.key,
    required this.onChanged,
    required this.onFilterTap,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // surface = white in light, dark card in dark mode.
                color: cs.surface,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    // Shadow visible only in light mode; outline handles dark.
                    color: isLight
                        ? Colors.black.withOpacity(0.08)
                        : Colors.transparent,
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: isLight
                    ? null
                    : Border.all(color: cs.outline, width: 0.5),
              ),
              child: TextField(
                onChanged: onChanged,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                // Input text colour from live theme.
                style: TextStyle(fontSize: 16, color: cs.onSurface),
                decoration: InputDecoration(
                  hintText: '...البحث عن الفنادق',
                  // Migrated from frozen font17MediumBlack global.
                  hintStyle: AppTextStyles.font17MediumBlack(context).copyWith(
                    color: cs.surfaceTint, // textMuted slot
                  ),
                  prefixIcon: GestureDetector(
                    onTap: onFilterTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: SvgPicture.asset(
                        'assets/icons/filter-search.svg',
                        colorFilter: ColorFilter.mode(
                          cs.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 20.h,
                    minWidth: 20.w,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/search-normal.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 20.w,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_forward,
              // onSurface = primary text colour, adapts in dark mode.
              color: cs.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
