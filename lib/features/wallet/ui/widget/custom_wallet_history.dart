import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../date/wallet_cubit.dart';
import '../../date/wallet_state.dart';
import 'custom_detail_row.dart';

class CustomWalletHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final trx = state.transactions[index];
              final isNegative = (trx['amount'] as num) < 0;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isNegative ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                  child: Icon(
                    isNegative ? Icons.call_made : Icons.call_received,
                    color: isNegative ? Colors.red : Colors.green,
                  ),
                ),
                title: Text(trx['description'] ?? "معاملة محفظة"),
                subtitle: Text(trx['created_at'].toString().substring(0, 10)),
                trailing: Text(
                  "${trx['amount']} EGP",
                  style: TextStyle(
                    color: isNegative ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}