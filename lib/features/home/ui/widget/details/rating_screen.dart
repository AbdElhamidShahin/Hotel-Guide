import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/details/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/network/model/hotel_model.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    // قراءة الـ ColorScheme هنا لتوفير استدعاء متكرر تحت
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Share.share(hotelModel.location),
          child: _buildCircularIcon(
            image: 'assets/icons/rating/Share_Icon_UIA.svg',
            colorScheme: colorScheme,
          ),
        ),
        SizedBox(width: 16.w),
        const AnimatedLikeButton(),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const RatingDialog(),
          ),
          child: _buildCircularIcon(
            image: 'assets/icons/rating/star.svg',
            colorScheme: colorScheme,
          ),
        ),
      ],
    );
  }

  /// التعديل: تمرير الـ ColorScheme لتتحول الأيقونات تلقائياً حسب وضع الشاشة
  Widget _buildCircularIcon({required String image, required ColorScheme colorScheme}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // outline يعطي لون حدود رمادي خفيف يتناسب تماماً مع الخلفيات البيضاء والسوداء
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      child: SvgPicture.asset(
        image,
        height: 24.r,
        width: 24.r,
        // onSurface يضمن أن تظهر الأيقونة باللون الأسود في اللايت وباللون الأبيض في الدارك
        colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
      ),
    );
  }
}

class AnimatedLikeButton extends StatefulWidget {
  const AnimatedLikeButton({super.key});

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() => isLiked = !isLiked);
    if (isLiked) _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              // التعديل: إذا لم يضغط يعطي لون متوافق مع الثيم الحالي، وإذا ضغط يتحول للأحمر
              color: isLiked ? Colors.red : colorScheme.outline,
              width: 1,
            ),
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            'assets/icons/rating/like.svg',
            height: 24.r,
            width: 24.r,
            colorFilter: ColorFilter.mode(
              isLiked ? Colors.red : colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}