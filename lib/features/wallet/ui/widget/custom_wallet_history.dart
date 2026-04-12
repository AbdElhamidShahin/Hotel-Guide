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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 6.h),
          child: Text(
            "اليوم",
            style: textStyle16BoldWhite.copyWith(color: AppColors.primary),
          ),
        ),

        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WalletLoaded) {
              if (state.transactions.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Text(
                      "لا توجد عمليات سابقة",
                      style: textStyle16RegularGray,
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final trx = state.transactions[index];
                  // 'bookings' is the joined relation from fetchWalletData
                  final booking = trx['bookings'] as Map<String, dynamic>?;
                  final transactionType =
                      trx['transaction_type'] ?? trx['type'] ?? 'payment';
                  final isTopUp = transactionType == 'top_up';
                  final amount = (trx['amount'] as num).toDouble().abs();
                  final dateStr = (trx['created_at'] as String).substring(0, 10);
                  final hotelName = booking != null
                      ? booking['hotel_name'] as String?
                      : trx['hotel_name'] as String?;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.ShadowPurple.withOpacity(.2),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          CustomDetailRow(
                            isTopUp ? 'شحن رصيد' : 'دفع حجز',
                            ':نوع العملية',
                            isTopUp
                                ? 'assets/icons/empty-wallet-add.svg'
                                : 'assets/icons/dollar-circle.svg',
                            isTopUp ? AppColors.Green : AppColors.primary,
                          ),
                          if (!isTopUp && hotelName != null) ...[
                            SizedBox(height: 12.h),
                            CustomDetailRow(
                              hotelName,
                              ':اسم الفندق',
                              'assets/icons/Hotel.svg',
                              AppColors.RoyalPurple,
                            ),
                          ],
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            dateStr,
                            ':التاريخ',
                            'assets/icons/calendar-tick.svg',
                            AppColors.primary,
                          ),
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            '${amount.toStringAsFixed(2)} EGP',
                            ':المبلغ',
                            'assets/icons/dollar-circle.svg',
                            AppColors.primary,
                          ),
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            trx['status'] == 'completed' ? 'مكتملة' : 'معلقة',
                            ':الحالة',
                            'assets/icons/tick-circle.svg',
                            AppColors.Green,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is WalletError) {
              Center(child: Text("حدث خطأ ما"));
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}