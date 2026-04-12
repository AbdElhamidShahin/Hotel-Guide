import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../payment/ui/widget/payment_summary_section.dart';
import '../../logic/wallet_cubit.dart';
import '../../logic/wallet_state.dart';

class CustomTopupHistory extends StatefulWidget {
  const CustomTopupHistory({super.key});

  @override
  State<CustomTopupHistory> createState() => _CustomTopupHistoryState();
}

class _CustomTopupHistoryState extends State<CustomTopupHistory> {
  String _selectedPayment = 'card';
  double _selectedAmount = 100;

  static const _amounts = [50.0, 100.0, 200.0, 500.0, 1000.0];

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletTopUpSuccess) {
          _showSuccessDialog(state.newBalance);
        } else if (state is WalletTopUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 24.h),
            child: Text(
              'شحن رصيد',
              style: textStyle20BoldShadowPurple.copyWith(
                color: AppColors.black7,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'اختر المبلغ',
                  style: textStyle16RegularGray.copyWith(
                    color: AppColors.black7,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: _amounts.map((amount) {
                    final isSelected = _selectedAmount == amount;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAmount = amount),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.ShadowPurple.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          '${amount.toInt()} EGP',
                          style: textStyle16RegularGray.copyWith(
                            color: isSelected ? Colors.white : AppColors.black7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          PaymentTile(
            title: 'المحفظة الإلكترونية',
            selected: _selectedPayment == 'wallet',
            onTap: () => setState(() => _selectedPayment = 'wallet'),
            trailing: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.ShadowPurple.withOpacity(0.1),
              ),
              child: SvgPicture.asset('assets/icons/empty-wallet.svg'),
            ),
          ),

          SizedBox(height: 16.h),

          PaymentTile(
            title: 'البطاقة البنكية',
            selected: _selectedPayment == 'card',
            onTap: () => setState(() => _selectedPayment = 'card'),
            trailing: Row(
              children: [
                SvgPicture.asset('assets/icons/MasterCard.svg'),
                SizedBox(width: 8.w),
                SvgPicture.asset('assets/icons/Visa.svg'),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              final isLoading = state is WalletTopUpLoading;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () => _onConfirmTopUp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'شحن ${_selectedAmount.toInt()} EGP',
                            style: textStyle20BoldShadowPurple.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onConfirmTopUp(BuildContext context) {
    if (_selectedPayment == 'card') {
      context.read<WalletCubit>().topUpWallet(amount: _selectedAmount);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الشحن عبر المحافظ الأخرى قريباً!')),
      );
    }
  }

  void _showSuccessDialog(double newBalance) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تم شحن الرصيد ✅'),
        content: Text(
          'تمت إضافة ${_selectedAmount.toInt()} EGP بنجاح.\nرصيدك الجديد: ${newBalance.toStringAsFixed(2)} EGP',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
