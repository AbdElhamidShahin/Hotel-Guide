import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CardCubit>()..loadCards(),
      child: const _SavedCardsView(),
    );
  }
}

class _SavedCardsView extends StatelessWidget {
  const _SavedCardsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardCubit, CardState>(
      listener: (context, state) {
        if (state is CardSaved) {
          showCustomSnackbar(
            context,
            ContentType.success,
            'تم ✅',
            'تم حفظ البطاقة بنجاح',
          );
        } else if (state is CardError) {
          showCustomSnackbar(
            context,
            ContentType.failure,
            'خطأ ❌',
            state.message,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: CustomAppbarWidget(
          name: 'بطاقاتي المحفوظة',
          onTap: () => context.pop(),
        ),
        body: BlocBuilder<CardCubit, CardState>(
          builder: (context, state) {

            // ── Loading ────────────────────────────────────────────────
            if (state is CardLoading || state is CardSetupLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final cards = state is CardsLoaded ? state.cards : <SavedCardEntity>[];

            return ListView(
              padding: EdgeInsets.all(20.w),
              children: [

                // ── Header Info ────────────────────────────────────────
                _InfoBanner(),
                SizedBox(height: 20.h),

                // ── Saved Cards ────────────────────────────────────────
                if (cards.isNotEmpty) ...[
                  Text(
                    'بطاقاتك المحفوظة',
                    style: textStyle16BoldWhite.copyWith(
                      color: AppColors.black6,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 12.h),
                  ...cards.map(
                        (card) => _CardManagementTile(
                      card: card,
                      onDelete: () => _confirmDelete(context, card),
                      onSetDefault: card.isDefault
                          ? null
                          : () => context.read<CardCubit>().setDefaultCard(card),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ] else ...[
                  _EmptyCardsView(),
                  SizedBox(height: 20.h),
                ],

                // ── Add New Card ───────────────────────────────────────
                _AddNewCardButton(
                  onTap: () => context.read<CardCubit>().addNewCard(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Confirm Delete Dialog ───────────────────────────────────────────────────
  void _confirmDelete(BuildContext context, SavedCardEntity card) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'حذف البطاقة',
          textAlign: TextAlign.right,
          style: textStyle16BoldWhite.copyWith(color: AppColors.black6),
        ),
        content: Text(
          'هل تريد حذف بطاقة **** ${card.last4}؟',
          textAlign: TextAlign.right,
          style: textStyle14RegularNightfall,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(color: Colors.grey, fontFamily: 'Cairo'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CardCubit>().deleteCard(card.id);
            },
            child: Text(
              'حذف',
              style: TextStyle(color: Colors.red, fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Info Banner ──────────────────────────────────────────────────────────────

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(
            Icons.security_outlined,
            color: AppColors.primary,
            size: 22.r,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'بطاقاتك محفوظة بأمان عبر Stripe — لا نحفظ أرقام بطاقاتك على خوادمنا',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.primary,
                fontFamily: 'Cairo',
                height: 1.6,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Card Management Tile ─────────────────────────────────────────────────────

class _CardManagementTile extends StatelessWidget {
  const _CardManagementTile({
    required this.card,
    required this.onDelete,
    this.onSetDefault,
  });

  final SavedCardEntity card;
  final VoidCallback onDelete;
  final VoidCallback? onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: card.isDefault
            ? Border.all(color: AppColors.primary, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // ── Brand Icon ───────────────────────────────────────────────
          SvgPicture.asset(card.brandIcon, width: 44.w),
          SizedBox(width: 14.w),

          // ── Card Info ────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      card.isVisa ? 'Visa' : 'Master Card',
                      style: textStyle16BoldWhite.copyWith(
                        color: AppColors.black6,
                      ),
                    ),
                    if (card.isDefault) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'افتراضية',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '${card.maskedNumber}   •   ${card.expiry}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontFamily: 'Cairo',
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // ── Actions ──────────────────────────────────────────────────
          Column(
            children: [
              // Set Default
              if (onSetDefault != null)
                GestureDetector(
                  onTap: onSetDefault,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.star_border_rounded,
                      color: AppColors.primary,
                      size: 18.r,
                    ),
                  ),
                ),
              SizedBox(height: 6.h),
              // Delete
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 18.r,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Empty View ───────────────────────────────────────────────────────────────

class _EmptyCardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          Icon(
            Icons.credit_card_off_outlined,
            size: 64.r,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد بطاقات محفوظة',
            style: textStyle16RegularGray,
          ),
          SizedBox(height: 8.h),
          Text(
            'أضف بطاقتك الآن لتسريع عملية الدفع',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Add New Card Button ──────────────────────────────────────────────────────

class _AddNewCardButton extends StatelessWidget {
  const _AddNewCardButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 18.r),
            ),
            SizedBox(width: 12.w),
            Text(
              'إضافة بطاقة جديدة',
              style: textStyle16BoldWhite.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}