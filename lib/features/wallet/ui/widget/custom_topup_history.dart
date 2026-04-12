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
  double _selectedAmount = 100;
  final _amountController = TextEditingController(text: '100');
  final _formKey = GlobalKey<FormState>();
  static const _shortcuts = [50.0, 100.0, 200.0, 500.0, 1000.0];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _setFromChip(double v) {
    setState(() {
      _selectedAmount = v;
      _amountController.text = v.toInt().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletTopUpSuccess) {
          Future.delayed(const Duration(milliseconds: 800), () {
            context.read<WalletCubit>().fetchWalletData();
          });
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('تم شحن الرصيد ✅'),
              content: Text(
                'تمت إضافة ${_selectedAmount.toStringAsFixed(2)} EGP بنجاح.\n'
                'رصيدك الجديد: ${state.newBalance.toStringAsFixed(2)} EGP',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('حسناً'),
                ),
              ],
            ),
          );
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
            padding: EdgeInsets.only(right: 24.w, top: 32.h, bottom: 20.h),
            child: Text(
              'شحن رصيد',
              style: textStyle20BoldShadowPurple.copyWith(
                color: AppColors.black7,
              ),
            ),
          ),

          // Amount input
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                    validator: (v) {
                      if (v == null || v.trim().isEmpty)
                        return 'يرجى إدخال المبلغ';
                      final p = double.tryParse(v.trim());
                      if (p == null || p <= 0) return 'مبلغ غير صحيح';
                      return null;
                    },
                    onChanged: (v) {
                      final p = double.tryParse(v.trim());
                      if (p != null && p > 0)
                        setState(() => _selectedAmount = p);
                    },
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'أو اختر مبلغاً سريعاً',
                    style: textStyle16RegularGray.copyWith(
                      color: AppColors.black7.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _shortcuts.map((a) {
                      final sel =
                          _selectedAmount == a &&
                          _amountController.text == a.toInt().toString();
                      return GestureDetector(
                        onTap: () => _setFromChip(a),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: sel
                                ? AppColors.primary
                                : AppColors.ShadowPurple.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: sel
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            '${a.toInt()} EGP',
                            style: textStyle16RegularGray.copyWith(
                              color: sel ? Colors.white : AppColors.black7,
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

          SizedBox(height: 20.h),

          // Card tile
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: PaymentTile(
              title: 'البطاقة البنكية',
              selected: true,
              onTap: () {},
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

          SizedBox(height: 24.h),

          // Confirm button
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              final loading = state is WalletTopUpLoading;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: loading ? null : () => _onConfirm(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'شحن ${_selectedAmount % 1 == 0 ? _selectedAmount.toInt() : _selectedAmount.toStringAsFixed(2)} EGP',
                            style: textStyle20BoldShadowPurple.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),

          // Past top-up history
          BlocBuilder<WalletCubit, WalletState>(
            buildWhen: (_, s) =>
                s is WalletLoading || s is WalletLoaded || s is WalletError,
            builder: (context, state) {
              if (state is! WalletLoaded || state.topUpTransactions.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 24.w,
                      top: 32.h,
                      bottom: 8.h,
                    ),
                    child: Text(
                      'سجل عمليات الشحن',
                      style: textStyle16BoldWhite.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.topUpTransactions.length,
                    itemBuilder: (_, i) =>
                        _TopUpCard(trx: state.topUpTransactions[i]),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final parsed = double.tryParse(_amountController.text.trim());
    if (parsed == null || parsed <= 0) return;
    _selectedAmount = parsed;
    context.read<WalletCubit>().topUpWallet(amount: _selectedAmount);
  }
}

class _TopUpCard extends StatelessWidget {
  final Map<String, dynamic> trx;
  const _TopUpCard({required this.trx});

  @override
  Widget build(BuildContext context) {
    final amount = (trx['amount'] as num? ?? 0).toDouble().abs();
    final dateRaw = trx['created_at'] as String? ?? '';
    final dateStr = dateRaw.length >= 10 ? dateRaw.substring(0, 10) : dateRaw;
    final status = trx['status'] == 'completed' ? 'مكتملة' : 'معلقة';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.Green.withOpacity(.2)),
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
            _r(
              'شحن رصيد',
              ':نوع العملية',
              'assets/icons/empty-wallet-add.svg',
              AppColors.Green,
            ),
            SizedBox(height: 10.h),
            _r(
              dateStr,
              ':التاريخ',
              'assets/icons/calendar-tick.svg',
              AppColors.primary,
            ),
            SizedBox(height: 10.h),
            _r(
              '+${amount.toStringAsFixed(2)} EGP',
              ':المبلغ المضاف',
              'assets/icons/dollar-circle.svg',
              AppColors.Green,
            ),
            SizedBox(height: 10.h),
            _r(
              status,
              ':الحالة',
              'assets/icons/tick-circle.svg',
              AppColors.Green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _r(String val, String label, String icon, Color color) {
    return Row(
      children: [
        Text(val, style: textStyle16RegularGray.copyWith(color: color)),
        const Spacer(),
        Text(
          label,
          style: textStyle16RegularGray.copyWith(color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(icon, width: 18, height: 18),
      ],
    );
  }
}
