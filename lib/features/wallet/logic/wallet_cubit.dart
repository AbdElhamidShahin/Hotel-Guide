import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/units/stripe_service.dart';
import '../../payment/data/model/payment_intent_input_model.dart';
import '../data/wallet_repo.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepository _repo;
  final StripeService _stripe;

  StreamSubscription? _walletSub;

  WalletCubit({required WalletRepository repo, required StripeService stripe})
      : _repo = repo,
        _stripe = stripe,
        super(WalletInitial());

  // ── Fetch ─────────────────────────────────────────

  Future<void> fetchWalletData() async {
    emit(WalletLoading());
    final result = await _repo.getWalletDetails();
    result.fold(
          (failure) => emit(WalletError(failure.message)),
          (data) => emit(
        WalletLoaded(
          userProfile: data.profile,
          paymentTransactions: data.payments,
          topUpTransactions: data.topUps,
        ),
      ),
    );
  }

  // ── Realtime Listener ─────────────────────────────
  // ✅ Fix #3: getUserId جه من الـ repo عبر getWalletDetails — مش من
  // Supabase.instance.client مباشر. الـ Cubit دلوقتي مش عارف حاجة عن Supabase.

  void startWalletListener() {
    // استخدم الـ userId اللي جه مع أول fetch بدل ما نكلم Supabase مباشر.
    // لو الـ state loaded → عندنا profile.id جاهز.
    final currentState = state;
    final userId = currentState is WalletLoaded
        ? currentState.userProfile.id
        : null;

    if (userId == null || userId.isEmpty) return;

    _walletSub?.cancel();

    _walletSub = _repo.watchWalletChanges(userId).listen((_) async {
      debugPrint('🔥 Wallet Realtime Triggered');
      await fetchWalletData();
    });
  }

  // ── Top-Up ───────────────────────────────────────

  Future<void> topUpWallet({required double amount}) async {
    final currentState = state;
    if (currentState is! WalletLoaded) return;

    final profile = currentState.userProfile;
    emit(WalletTopUpLoading());

    try {
      final customerId = await _stripe.getOrCreateStripeCustomerId(profile);

      await _stripe.makePayment(
        paymentIntentInputModel: PaymentIntentInputModel(
          amount: (amount * 100).toInt().toString(),
          currency: 'egp',
          customerId: customerId,
        ),
      );

      debugPrint('✅ Stripe payment success');

      final result = await _repo.topUpBalance(amount);

      await result.fold(
            (failure) async => emit(WalletTopUpError(failure.message)),
            (_) async {
          emit(WalletTopUpSuccess(profile.walletBalance + amount));
          await fetchWalletData();
        },
      );
    } catch (e) {
      debugPrint('❌ topUpWallet: $e');
      emit(WalletTopUpError(e.toString()));
    }
  }

  void stopWalletListener() {
    _walletSub?.cancel();
    _walletSub = null;
  }

  @override
  Future<void> close() {
    _walletSub?.cancel();
    return super.close();
  }
}
