import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../payment/ui/widget/payment_summary_section.dart';
import '../../../payment/ui/widget/show_all_card_bottom_sheet.dart';
import '../../../payment/ui/widget/show_all_wallet_bottom_sheet.dart';

class CustomTopupHistory extends StatefulWidget {
  const CustomTopupHistory({super.key});

  @override
  State<CustomTopupHistory> createState() => _CustomTopupHistoryState();
}

String selectedPayment = 'wallet';

class _CustomTopupHistoryState extends State<CustomTopupHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 24.h),
          child: Text(
            "شحن رصيد",
            style: textStyle20BoldShadowPurple.copyWith(
              color: AppColors.black7,
            ),
          ),
        ),
        PaymentTile(
          title: "المحفظة الإلكترونية",
          selected: selectedPayment == 'wallet',
          onTap: () {
            setState(() => selectedPayment = 'wallet');
            // showAllWalletBottomSheet(context);
          },
          trailing: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: AppColors.ShadowPurple.withOpacity(0.1),
            ),
            child: SvgPicture.asset("assets/icons/empty-wallet.svg"),
          ),
        ),

        SizedBox(height: 16.h),

        PaymentTile(
          title: "البطاقة البنكية",
          selected: selectedPayment == 'card',
          onTap: () {
            setState(() => selectedPayment = 'card');
            showAllCardBottomSheet(context);
          },

          trailing: Row(
            children: [
              SvgPicture.asset("assets/icons/MasterCard.svg"),
              SizedBox(width: 8.w),
              SvgPicture.asset("assets/icons/Visa.svg"),
            ],
          ),
        ),
      ],
    );
  }
}
