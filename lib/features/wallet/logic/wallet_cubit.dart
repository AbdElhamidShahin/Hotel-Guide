import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/units/stripe_service.dart';
import '../../payment/data/model/payment_intent_input_model.dart';
import '../data/wallet_repo.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepository _repo;
  final StripeService _stripe;

  WalletCubit({
    required WalletRepository repo,
    required StripeService stripe,
  })  : _repo = repo,
        _stripe = stripe,
        super(WalletInitial());

  // ── Fetch ─────────────────────────────────────────────────────────────────

  Future<void> fetchWalletData() async {
    emit(WalletLoading());
    final result = await _repo.getWalletDetails();
    result.fold(
          (failure) => emit(WalletError(failure.errorMessage)),
          (data) => emit(WalletLoaded(
        userProfile: data.profile,
        paymentTransactions: data.payments,
        topUpTransactions: data.topUps,
      )),
    );
  }

  // ── Top-Up ────────────────────────────────────────────────────────────────

  Future<void> topUpWallet({required double amount}) async {
    if (state is! WalletLoaded) return;
    final profile = (state as WalletLoaded).userProfile;

    emit(WalletTopUpLoading());
    try {
      // 1. Stripe payment
      final customerId = await _stripe.getOrCreateStripeCustomerId(profile);
      await _stripe.makePayment(
        paymentIntentInputModel: PaymentIntentInputModel(
          amount: (amount * 100).toInt().toString(),
          currency: 'egp',
          customerId: customerId,
        ),
      );

      // 2. Update DB via repo (RPC or manual fallback)
      final result = await _repo.topUpBalance(amount);
      result.fold(
            (failure) => emit(WalletTopUpError(failure.errorMessage)),
            (_) {
          emit(WalletTopUpSuccess(profile.walletBalance + amount));
          fetchWalletData(); // refresh list
        },
      );
    } catch (e) {
      emit(WalletTopUpError(e.toString()));
    }
  }
}