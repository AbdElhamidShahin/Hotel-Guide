import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/features/wallet/date/wallet_cubit.dart';
import 'package:hotel_guide/features/wallet/date/wallet_state.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
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
                  final booking = trx['bookings'];
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
                            "حجز",
                            ":نوع العملية",
                            "assets/icons/category.svg",
                            AppColors.primary,
                          ),
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            booking != null
                                ? booking['hotel_name']
                                : 'معاملة عامة',
                            ":اسم الفندق",
                            "assets/icons/hotel.svg",
                            AppColors.RoyalPurple,
                          ),
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            booking != null
                                ? booking['start_date']
                                : trx['created_at'].toString().substring(0, 10),
                            ":التاريخ",
                            "assets/icons/calendar.svg",
                            AppColors.primary,
                          ),
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            "${trx['amount'].abs()} EGP",
                            ":المبلغ",
                            "assets/icons/money.svg",
                            AppColors.primary,
                          ),
                          SizedBox(height: 12.h),
                          CustomDetailRow(
                            "مكتملة",
                            ":الحالة",
                            "assets/icons/tick-circle.svg",
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
