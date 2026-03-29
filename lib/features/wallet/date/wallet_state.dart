import 'package:hotel_guide/features/wallet/date/wallet_entity.dart';


/// Sealed state hierarchy for [WalletCubit].
///
/// ✅ WalletLoaded now carries typed domain Entities, NOT raw
///    `Map<String, dynamic>` from Supabase. The UI only sees clean objects.
abstract class WalletState {
  const WalletState();
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final WalletEntity wallet;
  final List<TransactionEntity> transactions;

  const WalletLoaded({
    required this.wallet,
    required this.transactions,
  });
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);
}
