import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class ImageGallerySection extends StatefulWidget {
  const ImageGallerySection({
    super.key,
    required this.images,
    this.vrUrl,
  });

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
    return Column(
      children: [
        SizedBox(height: 12.h),

        /// ================= MAIN IMAGE =================
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
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/onBoardingImage.jpg",
                        fit: BoxFit.cover,
                      );
                    },
                  )
                      : Image.asset(
                    "assets/images/onBoardingImage.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            /// Dots
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

        /// ================= GRID =================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: safeImages.isEmpty
                ? _buildEmptyGrid()
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
              safeImages.length > 4 ? 4 : safeImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (context, index) {
                bool isLast =
                (index == 3 && safeImages.length > 4);

                return GestureDetector(
                  onTap: () {
                    if (isLast) {
                      _showAllImagesBottomSheet(context);
                    } else {
                      setState(() {
                        selectedIndex = index;
                      });
                    }
                  },
                  child: _buildThumbnail(
                    safeImages[index],
                    isSelected: selectedIndex == index,
                    isLast: isLast,
                    count: isLast
                        ? "+${safeImages.length - 3}"
                        : null,
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: 24.h),

        /// ================= VR BUTTON =================
        if (widget.vrUrl != null && widget.vrUrl!.isNotEmpty)
          _buildVRButton(),
      ],
    );
  }

  /// ================= BOTTOM SHEET =================
  void _showAllImagesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                height: 5.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              Text(
                "صور الغرفة",
                style: textStyle1Regularprimary.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: safeImages.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        safeImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/onBoardingImage.jpg",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ================= DOT =================
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

  /// ================= THUMBNAIL =================
  Widget _buildThumbnail(
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
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/onBoardingImage.jpg",
                  fit: BoxFit.cover,
                );
              },
            ),
            if (isLast && count != null)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    count,
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

  /// ================= EMPTY GRID =================
  Widget _buildEmptyGrid() {
    return Container(
      height: 120.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.image_not_supported, size: 40),
          SizedBox(height: 8),
          Text("لا توجد صور متاحة"),
        ],
      ),
    );
  }

  /// ================= VR BUTTON =================
  Widget _buildVRButton() {
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
              SvgPicture.asset(
                  "assets/icons/AR-view-see-through-eye.svg"),
              const SizedBox(width: 12),
              Text(
                "مشاهدة الغرفة بالواقع الإفتراضي",
                style:
                textStyle22BoldPrimary.copyWith(fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}