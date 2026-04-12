import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/units/stripe_service.dart';
import '../../payment/data/model/payment_intent_input_model.dart';
import '../data/wallet_repo.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepository _repo;
  final StripeService _stripe;

  WalletCubit(this._repo, this._stripe) : super(WalletInitial());

  Future<void> fetchWalletData() async {
    emit(WalletLoading());
    final result = await _repo.getWalletDetails();
    result.fold(
          (f) => emit(WalletError(f.errorMessage)),
          (data) => emit(WalletLoaded(
        userProfile: data.profile,
        paymentTransactions: data.payments,
        topUpTransactions: data.topUps,
      )),
    );
  }

  Future<void> topUpWallet({required double amount}) async {
    if (state is! WalletLoaded) return;
    final profile = (state as WalletLoaded).userProfile;

    emit(WalletTopUpLoading());
    try {
      // Stripe logic
      final customerId = await _stripe.getOrCreateStripeCustomerId(profile);
      await _stripe.makePayment(paymentIntentInputModel: PaymentIntentInputModel(
        amount: (amount * 100).toInt().toString(),
        currency: 'egp',
        customerId: customerId,
      ));

      // Repository logic
      final result = await _repo.topUpBalance(amount);
      result.fold(
            (f) => emit(WalletTopUpError(f.errorMessage)),
            (_) {
          emit(WalletTopUpSuccess(profile.walletBalance + amount));
          fetchWalletData();
        },
      );
    } catch (e) {
      emit(WalletTopUpError(e.toString()));
    }
  }
}