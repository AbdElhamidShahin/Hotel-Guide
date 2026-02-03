import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_refund_history.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_topup_history.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_wallet_balance.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_wallet_history.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String currentView = 'history';
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbarWidget(onTap: () {}, name: "المحفظة"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomWalletBalance(
                onTabChanged: (view) {
                  setState(() {
                    currentView = view;
                  });
                },
              ),
              _buildSelectedView(currentView),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSelectedView(currentView) {
  switch (currentView) {
    case 'history':
      return const CustomWalletHistory();
    case 'refund':
      return const CustomRefundHistory();
    case 'topup':
      return CustomTopupHistory();

    default:
      return const CustomWalletHistory();
  }
}
