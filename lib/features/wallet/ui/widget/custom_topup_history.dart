import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_theme_data.dart';
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
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletTopUpSuccess) {
          context.read<WalletCubit>().fetchWalletData();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 24.w, top: 32.h, bottom: 20.h),
            child: Text(
              'شحن رصيد',
              style: AppTextStyles.font20BoldShadowPurple(
                context,
              ).copyWith(color: isDark ? Colors.white : cs.primary),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'أدخل المبلغ (EGP)',
                    style: AppTextStyles.font16RegularMuted(context).copyWith(
                      color: isDark ? Colors.white70 : AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _amountController,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark ? cs.surface : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: isDark ? cs.outline : cs.outlineVariant,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    children: _shortcuts.map((a) {
                      final sel = _selectedAmount == a;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedAmount = a),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: sel
                                ? AppColors.primary
                                : (isDark
                                      ? Colors.white10
                                      : AppColors.softGray),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            '${a.toInt()} EGP',
                            style: TextStyle(
                              color: sel
                                  ? Colors.white
                                  : (isDark ? Colors.white : Colors.black),
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
                            style: font20BoldShadowPurple.copyWith(
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
                      style: font16BoldWhite.copyWith(color: AppColors.primary),
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
          border: Border.all(color: AppColors.success.withOpacity(.2)),
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
              AppColors.success,
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
              AppColors.success,
            ),
            SizedBox(height: 10.h),
            _r(
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

  Widget _r(String val, String label, String icon, Color color) {
    return Row(
      children: [
        Text(val, style: font16RegularMuted.copyWith(color: color)),
        const Spacer(),
        Text(
          label,
          style: font16RegularMuted.copyWith(color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(icon, width: 18, height: 18),
      ],
    );
  }
}
