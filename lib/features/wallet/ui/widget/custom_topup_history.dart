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

  final TextEditingController _amountController = TextEditingController(
    text: '100',
  );
  final _formKey = GlobalKey<FormState>();

  // Quick-select shortcut chips
  static const _shortcuts = [50.0, 100.0, 200.0, 500.0, 1000.0];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  /// Syncs both the chip selection and the text field together
  void _setAmountFromChip(double amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toInt().toString();
    });
  }

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
          // ── Section title ─────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 24.h),
            child: Text(
              'شحن رصيد',
              style: textStyle20BoldShadowPurple.copyWith(
                color: AppColors.black7,
              ),
            ),
          ),

          // ── Amount input area ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Dynamic text field
                  Text(
                    'أدخل المبلغ (EGP)',
                    style: textStyle16RegularGray.copyWith(
                      color: AppColors.black7,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.center,
                    style: textStyle20BoldShadowPurple.copyWith(
                      color: AppColors.black7,
                    ),
                    decoration: InputDecoration(
                      hintText: 'مثال: 250',
                      suffixText: 'EGP',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: AppColors.ShadowPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يرجى إدخال المبلغ';
                      }
                      final parsed = double.tryParse(value.trim());
                      if (parsed == null || parsed <= 0) {
                        return 'يرجى إدخال مبلغ صحيح أكبر من صفر';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final parsed = double.tryParse(value.trim());
                      if (parsed != null && parsed > 0) {
                        setState(() => _selectedAmount = parsed);
                      }
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Quick-select chips
                  Text(
                    'أو اختر مبلغاً سريعاً',
                    style: textStyle16RegularGray.copyWith(
                      color: AppColors.black7.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _shortcuts.map((amount) {
                      final isSelected =
                          _selectedAmount == amount &&
                          _amountController.text == amount.toInt().toString();
                      return GestureDetector(
                        onTap: () => _setAmountFromChip(amount),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
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
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.black7,
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
          ),

          SizedBox(height: 24.h),

          // ── Payment method tiles ──────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: PaymentTile(
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
          ),

          SizedBox(height: 16.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: PaymentTile(
              title: 'البطاقة البنكية',
              selected: _selectedPayment == 'card',
              onTap: () => setState(() => _selectedPayment = 'card'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/MasterCard.svg'),
                  SizedBox(width: 8.w),
                  SvgPicture.asset('assets/icons/Visa.svg'),
                ],
              ),
            ),
          ),

          SizedBox(height: 32.h),

          // ── Confirm button ────────────────────────────────────────────────
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
                            'شحن ${_selectedAmount.toStringAsFixed(_selectedAmount % 1 == 0 ? 0 : 2)} EGP',
                            style: textStyle20BoldShadowPurple.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  void _onConfirmTopUp(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final parsed = double.tryParse(_amountController.text.trim());
    if (parsed == null || parsed <= 0) return;

    // Update _selectedAmount from field in case user typed manually
    _selectedAmount = parsed;

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
          'تمت إضافة ${_selectedAmount.toStringAsFixed(2)} EGP بنجاح.\n'
          'رصيدك الجديد: ${newBalance.toStringAsFixed(2)} EGP',
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
