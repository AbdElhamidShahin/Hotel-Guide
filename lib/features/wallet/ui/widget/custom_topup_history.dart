import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
            child: Text('شحن رصيد', style: AppTextStyles.font20BoldShadowPurple(context).copyWith(color: isDark ? Colors.white : AppColors.primary)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('أدخل المبلغ (EGP)', style: AppTextStyles.font16RegularMuted(context).copyWith(color: isDark ? Colors.white70 : AppColors.primary)),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _amountController,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark ? const Color(0xFF222225) : Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: isDark ? Colors.white24 : AppColors.softGray)),
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
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(color: sel ? AppColors.primary : (isDark ? Colors.white10 : AppColors.softGray), borderRadius: BorderRadius.circular(30.r)),
                          child: Text('${a.toInt()} EGP', style: TextStyle(color: sel ? Colors.white : (isDark ? Colors.white : Colors.black))),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              width: double.infinity, height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () {},
                child: Text('شحن', style: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}