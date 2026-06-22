import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
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
                  padding:
                  EdgeInsets.only(right: 24.w, top: 24.h, bottom: 8.h),
                  child: Text(
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

// ─────────────────────────────────────────────────────────────────────────────

class _PaymentCard extends StatelessWidget {
  final Map<String, dynamic> trx;
  const _PaymentCard({required this.trx});

  /// تحويل ISO string → "YYYY-MM-DD"
  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return '—';
    return raw.length >= 10 ? raw.substring(0, 10) : raw;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final amount  = (trx['amount'] as num? ?? 0).toDouble().abs();

    // ✅ Fix: hotel_name دلوقتي جاي من bookings عبر الـ join
    final hotelName = (trx['hotel_name'] as String?)?.isNotEmpty == true
        ? trx['hotel_name'] as String
        : '—';

    // ✅ Fix: check_in و check_out جايين من bookings
    final checkIn  = _formatDate(trx['check_in']  as String?);
    final checkOut = _formatDate(trx['check_out'] as String?);

    // ✅ Fix: الحالة من booking_status (من bookings) أدق
    final rawStatus = (trx['booking_status'] as String?)
        ?? (trx['status'] as String?)
        ?? '';
    final isFailed  = rawStatus == 'failed'   || rawStatus == 'cancelled';
    final isPending = rawStatus == 'pending'   || rawStatus == '';
    final statusText = isFailed
        ? 'فاشلة'
        : isPending
        ? 'قيد المعالجة'
        : 'مكتملة';
    final statusColor = isFailed
        ? AppColors.error
        : isPending
        ? Colors.orange
        : AppColors.success;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
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
              ':اسم الغرفه',
              'assets/icons/Hotel.svg',
              cs.primary,
            ),
            SizedBox(height: 10.h),

            CustomDetailRow(
              checkIn,
              ':تاريخ الحجز',
              'assets/icons/calendar-tick.svg',
              cs.onSurfaceVariant,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              checkOut,
              ':تاريخ الانتهاء',
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
