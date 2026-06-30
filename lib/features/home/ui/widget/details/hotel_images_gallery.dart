import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class HotelImagesGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final double borderRadius;

  const HotelImagesGallery({
    super.key,
    required this.images,
    this.height = 230,
    this.borderRadius = 20,
  });

  @override
  State<HotelImagesGallery> createState() => _HotelImagesGalleryState();
}

class _HotelImagesGalleryState extends State<HotelImagesGallery> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // لو مفيش صور خالص → placeholder
    if (widget.images.isEmpty) {
      return _buildPlaceholder(context);
    }

    // لو صورة واحدة بس → عرضها مباشر بدون swipe أو dots
    if (widget.images.length == 1) {
      return _buildSingleImage(widget.images.first);
    }

    // أكتر من صورة → Gallery كاملة
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPageView(context),
        SizedBox(height: 10.h),
        _buildDotsIndicator(context),
      ],
    );
  }

  // ─── Widgets ────────────────────────────────────────────────────────────────

  Widget _buildSingleImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      child: Image.network(
        url,
        width: double.infinity,
        height: widget.height.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _errorBox(),
        loadingBuilder: _loadingBuilder,
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      child: SizedBox(
        height: widget.height.h,
        child: Stack(
          children: [
            // ── الصور ──────────────────────────────────────────────────────
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemBuilder: (context, index) {
                return Image.network(
                  widget.images[index],
                  width: double.infinity,
                  height: widget.height.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _errorBox(),
                  loadingBuilder: _loadingBuilder,
                );
              },
            ),

            // ── سهم يسار ──────────────────────────────────────────────────
            if (_currentIndex < widget.images.length - 1)
              Positioned(
                left: 8.w,
                top: 0,
                bottom: 0,
                child: _NavArrow(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => _animateTo(_currentIndex + 1),
                ),
              ),

            // ── سهم يمين ──────────────────────────────────────────────────
            if (_currentIndex > 0)
              Positioned(
                right: 8.w,
                top: 0,
                bottom: 0,
                child: _NavArrow(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => _animateTo(_currentIndex - 1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Dots indicator — تتحرك مع الـ swipe
  Widget _buildDotsIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.images.length, (index) {
        final isActive = index == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          height: 6.r,
          width: isActive ? 18.w : 6.w,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      child: Container(
        width: double.infinity,
        height: widget.height.h,
        color: colorScheme.surfaceVariant,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: 40.r,
              color: colorScheme.outlineVariant,
            ),
            SizedBox(height: 8.h),
            Text(
              'لا توجد صور متاحة',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  void _animateTo(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  Widget _errorBox() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40),
      ),
    );
  }

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;
    return Container(
      color: Colors.grey.shade100,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
              : null,
          strokeWidth: 2,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

/// Counter في الركن مثل "1 / 5"
class _ImageCounter extends StatelessWidget {
  final int current;
  final int total;

  const _ImageCounter({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '$current / $total',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20.r),
        ),
      ),
    );
  }
}
