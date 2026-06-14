import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class ImageGallerySection extends StatefulWidget {
  const ImageGallerySection({super.key, required this.images, this.vrUrl});

  final List<String> images;
  final String? vrUrl;

  @override
  State<ImageGallerySection> createState() => _ImageGallerySectionState();
}

class _ImageGallerySectionState extends State<ImageGallerySection> {
  int selectedIndex = 0;

  List<String> get safeImages =>
      widget.images.where((e) => e.isNotEmpty).toList();

  String? get currentImage {
    if (safeImages.isNotEmpty &&
        selectedIndex < safeImages.length &&
        safeImages[selectedIndex].isNotEmpty) {
      return safeImages[selectedIndex];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        SizedBox(height: 12.h),

        // ── MAIN IMAGE ──────────────────────────────────────────────────
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: currentImage != null
                      ? Image.network(
                          currentImage!,
                          key: ValueKey(currentImage),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/onBoardingImage.jpg',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/images/onBoardingImage.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),

            // Dots — always white, sit on top of a photo.
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  safeImages.length,
                  (index) => _buildDot(index == selectedIndex),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // ── THUMBNAIL GRID ──────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              // surface = white in light, dark card in dark mode.
              color: cs.surface,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  // Shadow visible in light only; border handles dark depth.
                  color: isLight
                      ? Colors.black.withOpacity(0.15)
                      : Colors.transparent,
                  blurRadius: 10,
                ),
              ],
              border: isLight
                  ? null
                  : Border.all(color: cs.outline, width: 0.5),
            ),
            child: safeImages.isEmpty
                ? _buildEmptyGrid(context)
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: safeImages.length > 4 ? 4 : safeImages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (context, index) {
                      bool isLast = (index == 3 && safeImages.length > 4);
                      return GestureDetector(
                        onTap: () {
                          if (isLast) {
                            _showAllImagesBottomSheet(context);
                          } else {
                            setState(() => selectedIndex = index);
                          }
                        },
                        child: _buildThumbnail(
                          context,
                          safeImages[index],
                          isSelected: selectedIndex == index,
                          isLast: isLast,
                          count: isLast ? '+${safeImages.length - 3}' : null,
                        ),
                      );
                    },
                  ),
          ),
        ),

        SizedBox(height: 24.h),

        // ── VR BUTTON ───────────────────────────────────────────────────
        if (widget.vrUrl != null && widget.vrUrl!.isNotEmpty) _buildVRButton(context),
      ],
    );
  }

  // ── BOTTOM SHEET ────────────────────────────────────────────────────────
  void _showAllImagesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor handled by BottomSheetThemeData in AppThemeData.
      backgroundColor: Colors.transparent,
      builder: (context) {
        final cs = Theme.of(context).colorScheme;
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            // surface = white in light, dark card in dark mode.
            color: cs.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                height: 5.h,
                width: 40.w,
                decoration: BoxDecoration(
                  // outline = themed drag handle, correct shade in both modes.
                  color: cs.outline,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              // Migrated from frozen font17RegularPrimary global.
              Text(
                'صور الغرفة',
                style: AppTextStyles.font17RegularPrimary(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(height: 1, color: cs.outline),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: safeImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      safeImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/onBoardingImage.jpg',
                        fit: BoxFit.cover,
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

  // ── DOT ───────────────────────────────────────────────────────────────────
  // Always white — dots sit directly on top of a photograph.
  Widget _buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      width: active ? 12.w : 6.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }

  // ── THUMBNAIL ─────────────────────────────────────────────────────────────
  Widget _buildThumbnail(
    BuildContext context,
    String url, {
    required bool isSelected,
    bool isLast = false,
    String? count,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected
            ? Border.all(color: AppColors.primaryDark, width: 2)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/onBoardingImage.jpg',
                fit: BoxFit.cover,
              ),
            ),
            if (isLast && count != null)
              Container(
                // Always dark overlay — sits on top of a photo.
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    count,
                    // Always white — text on dark photo overlay.
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── EMPTY GRID ────────────────────────────────────────────────────────────
  Widget _buildEmptyGrid(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 120.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // onSurfaceVariant = secondary icon colour, adapts in dark mode.
          Icon(Icons.image_not_supported, size: 40, color: cs.onSurfaceVariant),
          const SizedBox(height: 8),
          Text(
            'لا توجد صور متاحة',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  // ── VR BUTTON ─────────────────────────────────────────────────────────────
  // Always primary — branded action button, same in both themes.
  Widget _buildVRButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Container(
        width: 365.w,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/AR-view-see-through-eye.svg'),
              const SizedBox(width: 12),
              // Migrated from frozen font22BoldPrimary global.
              // Always white — on primary-coloured button.
              Text(
                'مشاهدة الغرفة بالواقع الإفتراضي',
                style: AppTextStyles.font22BoldPrimary(context).copyWith(fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
