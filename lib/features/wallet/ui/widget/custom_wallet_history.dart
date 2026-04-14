import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../logic/wallet_cubit.dart';
import '../../logic/wallet_state.dart';
import 'custom_detail_row.dart';

class CustomWalletHistory extends StatelessWidget {
  const CustomWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Text(state.message, style: font16RegularMuted),
            ),
          );
        }
        if (state is WalletLoaded) {
          final txns = state.paymentTransactions;
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<WalletCubit>().fetchWalletData();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 24.w, top: 24.h, bottom: 8.h),
                  child: Text(
                    'سجل الحجوزات',
                    style: font16BoldWhite.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (txns.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Center(
                      child: Text(
                        'لا توجد حجوزات سابقة',
                        style: font16RegularMuted,
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
    final amount = (trx['amount'] as num? ?? 0).toDouble().abs();
    final hotelName = (trx['hotel_name'] as String?) ?? '—';
    final dateRaw =
        trx['booking_date'] as String? ?? trx['created_at'] as String? ?? '';
    final dateStr = dateRaw.length >= 10 ? dateRaw.substring(0, 10) : dateRaw;
    final desc = (trx['description'] as String? ?? '');
    final method = desc.contains('بطاقة') ? 'بطاقة بنكية' : 'محفظة AQUA';
    final status = trx['status'] == 'completed' ? 'مكتملة' : 'معلقة';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.ShadowPurple.withOpacity(.15)),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            CustomDetailRow(
              'دفع حجز',
              ':نوع العملية',
              'assets/icons/dollar-circle.svg',
              AppColors.primary,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              hotelName,
              ':اسم الفندق',
              'assets/icons/Hotel.svg',
              AppColors.accent,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              dateStr,
              ':تاريخ الحجز',
              'assets/icons/calendar-tick.svg',
              AppColors.primary,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              '${amount.toStringAsFixed(2)} EGP',
              ':المبلغ',
              'assets/icons/dollar-circle.svg',
              AppColors.primary,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              method,
              ':طريقة الدفع',
              'assets/icons/empty-wallet.svg',
              AppColors.ShadowPurple,
            ),
            SizedBox(height: 10.h),
            CustomDetailRow(
              status,
              ':الحالة',
              'assets/icons/tick-circle.svg',
              AppColors.success,
            ),
          ],
        ),
      ),
    );
  }
}
