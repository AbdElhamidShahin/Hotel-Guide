import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/model/booking_model.dart';
import '../../logic/booking_cubit.dart';
import '../../logic/booking_state.dart';

void showWalletBottomSheet(
    BuildContext parentContext,
    BookingEntity bookingData,
    ) {
  final cubit = parentContext.read<BookingCubit>();

  showModalBottomSheet(
    context: parentContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: _WalletSheetContent(bookingData: bookingData),
      );
    },
  );
}

class _WalletSheetContent extends StatelessWidget {
  final BookingEntity bookingData;
  const _WalletSheetContent({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          Navigator.of(context).pop(); // close bottom sheet
          // Show success snackbar, etc.
        } else if (state is BookingError) {
          Navigator.of(context).pop(); // close loading indicator if any
          // Show error snackbar
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();
        final selectedWallet = state is BookingInitial
            ? state.selectedWallet
            : (cubit.state is BookingInitial
            ? (cubit.state as BookingInitial).selectedWallet
            : 'AQUA');

        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          // ... rest of UI using cubit and selectedWallet
          child: Column(
            children: [
              // ... wallet items with onTap: () => cubit.changeWallet(wallet)
              ElevatedButton(
                onPressed: () => cubit.confirmWithWallet(bookingData),
                child: Text('تأكيد دفع ${bookingData.totalAmount.toInt()} EGP'),
              ),
            ],
          ),
        );
      },
    );
  }
}