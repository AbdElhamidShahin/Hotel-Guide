import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/details/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/network/model/hotel_model.dart';
import '../../../../favorite/logic/cubit/favorite_cubit.dart';
import '../../../../favorite/logic/cubit/favorite_state.dart';

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
        AnimatedLikeButton(hotelModel: hotelModel),
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
  const AnimatedLikeButton({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with SingleTickerProviderStateMixin {
  // ✅ Fix #7: أزرق واضح ومخصص للايك — AppColors.accent بنفسجي مايل
  // للأزرق وليس أزرق صافي، فاستخدمنا لون أزرق صريح بدل كده.
  static const Color _likeBlue = Color(0xFF2F8FFF);

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // ✅ Fix #7: مدة أطول شوية ومنحنى "elastic" بدل linear easeInOut
      // عشان يعطي إحساس "نطّة" حقيقية ولطيفة عند الضغط، مش سكيل بسيط.
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 0.95), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(FavoriteCubit favoriteCubit) {
    // ✅ Fix #7: الزر دلوقتي متصل فعلياً بـ FavoriteCubit (نظام المفضلة
    // الحقيقي) بدل ما يكون مجرد متغير شكلي محلي مش بيحفظ أي حاجة.
    favoriteCubit.toggleFavorite(widget.hotelModel);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final favoriteCubit = context.read<FavoriteCubit>();

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final isLiked = favoriteCubit.isFavorite(widget.hotelModel);

        return GestureDetector(
          onTap: () => _handleTap(favoriteCubit),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ✅ Fix #7: لون أزرق جذاب بدل الأحمر التقليدي للايك.
                border: Border.all(
                  color: isLiked ? _likeBlue : colorScheme.outline,
                  width: 1,
                ),
                color: Colors.transparent,
              ),
              child: SvgPicture.asset(
                'assets/icons/rating/like.svg',
                height: 24.r,
                width: 24.r,
                colorFilter: ColorFilter.mode(
                  isLiked ? _likeBlue : colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}