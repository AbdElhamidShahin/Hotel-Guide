import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../core/helpers/contact/build_error_widget.dart';
import '../logic/wallet_cubit.dart';
import '../logic/wallet_state.dart';
import 'widget/custom_wallet_balance.dart';
import 'widget/custom_wallet_history.dart';
import 'widget/custom_topup_history.dart';
import 'widget/custom_refund_history.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String _activeSection = 'history';

  @override
  void initState() {
    super.initState();
    context.read<WalletCubit>().fetchWalletData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Inherits scaffoldBackgroundColor from AppThemeData automatically.
      body: BlocBuilder<WalletCubit, WalletState>(
        buildWhen: (_, s) =>
            s is WalletLoading || s is WalletLoaded || s is WalletError,
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WalletError) {
            return buildNoConnectionWidget(
              onRetry: () => context.read<WalletCubit>().fetchWalletData(),
            );
          }
          if (state is WalletLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context.read<WalletCubit>().fetchWalletData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    CustomWalletBalance(
                      profileModel: state.userProfile,
                      onTabChanged: (tab) =>
                          setState(() => _activeSection = tab),
                    ),
                    _buildActiveSection(),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildActiveSection() {
    return switch (_activeSection) {
      'topup'   => const CustomTopupHistory(),
      'refund'  => const CustomRefundHistory(),
      _         => const CustomWalletHistory(),
    };
  }
}
