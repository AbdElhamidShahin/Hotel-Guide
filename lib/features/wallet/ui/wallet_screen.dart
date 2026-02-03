import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/features/wallet/date/wallet_state.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_refund_history.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_topup_history.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_wallet_balance.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_wallet_history.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../date/wallet_cubit.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletCubit>().fetchWalletData();
  }

  String currentView = 'history';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(onTap: () {}, name: "المحفظة"),
      body: SingleChildScrollView(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomWalletBalance(
                    onTabChanged: (view) {
                      setState(() {
                        currentView = view;
                      });
                    },
                    profileModel: state.userProfile,
                  ),
                  _buildSelectedView(currentView),
                  SizedBox(height: 60.h),
                ],
              );
            } else if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text("حدث خطأ ما"));
            }
          },
        ),
      ),
    );
  }
}

Widget _buildSelectedView(currentView) {
  switch (currentView) {
    case 'history':
      return CustomWalletHistory();
    case 'refund':
      return const CustomRefundHistory();
    case 'topup':
      return CustomTopupHistory();

    default:
      return CustomWalletHistory();
  }
}
