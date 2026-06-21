import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart'; // تأكد من استيراد ملف الألوان الخاص بك
import '../../logic/wallet_cubit.dart';
import '../../logic/wallet_state.dart';
import 'custom_detail_row.dart';

class CustomWalletHistory extends StatelessWidget {
  const CustomWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<WalletCubit, WalletState>(
      buildWhen: (_, s) =>
          s is WalletLoading || s is WalletLoaded || s is WalletError,
      builder: (context, state) {
        if (state is WalletLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is WalletError) {
          return Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Center(
              child: Text(
                state.message,
                style: AppTextStyles.font16RegularMuted(context),
              ),
            ),
          );
        }
        if (state is WalletLoaded) {
          final txns = state.paymentTransactions;
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<WalletCubit>().fetchWalletData(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 24.w, top: 24.h, bottom: 8.h),
                  child:Text(
                    'سجل الحجوزات',
                    style: AppTextStyles.font16BoldWhite(context).copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : cs.primary,
                    ),
                  ),
                ),
                if (txns.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Center(
                      child: Text(
                        'لا توجد حجوزات سابقة',
                        style: AppTextStyles.font16RegularMuted(context),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: txns.length,
                    itemBuilder: (_, i) => _PaymentCard(trx: txns[i]),
                  ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final Map<String, dynamic> trx;
  const _PaymentCard({required this.trx});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final amount = (trx['amount'] as num? ?? 0).toDouble().abs();
    final hotelName = (trx['hotel_name'] as String?) ?? '—';
    final roomName = (trx['room_name'] as String?) ?? '—';
    final dateRaw =
        trx['booking_date'] as String? ?? trx['created_at'] as String? ?? '';
    final dateStr = dateRaw.length >= 10 ? dateRaw.substring(0, 10) : dateRaw;
    // ✅ Fix #2: الحالة دلوقتي دايمًا "مكتملة" باللون الأخضر، إلا لو
    // فعليًا فاشلة (failed) — مفيش حالة "معلقة" بعد ما تتسجل المعاملة.
    final isFailed = trx['status'] == 'failed';
    final statusText = isFailed ? 'فاشلة' : 'مكتملة';
    final statusColor = isFailed ? AppColors.error : AppColors.success;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          // نستخدم ألوان الـ Theme الأساسية لضمان التوافق
          color: cs.surface,
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: [
            CustomDetailRow(
              'دفع حجز',
              ':نوع العملية',
              'assets/icons/dollar-circle.svg',
              cs.onSurfaceVariant,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              hotelName,
              ':اسم الفندق',
              'assets/icons/Hotel.svg',
              cs.primary,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              roomName,
              ':اسم الغرفة',
              'assets/icons/Hotel.svg',
              cs.primary,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              dateStr,
              ':تاريخ الحجز',
              'assets/icons/calendar-tick.svg',
              cs.onSurfaceVariant,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              '${amount.toStringAsFixed(2)} EGP',
              ':المبلغ',
              'assets/icons/dollar-circle.svg',
              cs.onSurfaceVariant,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              statusText,
              ':الحالة',
              'assets/icons/tick-circle.svg',
              statusColor,
            ),
          ],
        ),
      ),
    );
  }
}
