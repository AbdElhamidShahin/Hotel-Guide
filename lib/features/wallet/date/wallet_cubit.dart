import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../logic/i_wallet_repository.dart';
import 'model/fetch_wallet_usecase.dart';
import 'wallet_state.dart';

/// ✅ Clean WalletCubit: zero Supabase imports, zero direct DB calls.
///
/// Before: had `final _client = Supabase.instance.client` as a field,
///         called Supabase directly from within the Cubit.
///
/// After:  receives [IWalletRepository] via constructor injection.
///         Delegates data fetching entirely to [FetchWalletUseCase].
class WalletCubit extends Cubit<WalletState> {
  final FetchWalletUseCase _fetchWalletUseCase;

  WalletCubit(IWalletRepository repository)
      : _fetchWalletUseCase = FetchWalletUseCase(repository),
        super(const WalletInitial());

  // ── Commands ───────────────────────────────────────────────────────────

  Future<void> fetchWalletData() async {
    emit(const WalletLoading());
    try {
      // userId comes from Supabase auth — this is acceptable in the Cubit
      // because auth state is an app-level concern, not a DB call.
      final userId = Supabase.instance.client.auth.currentUser?.id ?? '';

      final result = await _fetchWalletUseCase(userId);

      emit(WalletLoaded(
        wallet: result.wallet,
        transactions: result.transactions,
      ));
    } on WalletException catch (e) {
      emit(WalletError(e.message));
    } catch (e) {
      emit(const WalletError('فشل في تحميل بيانات المحفظة.'));
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
