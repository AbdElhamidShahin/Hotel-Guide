abstract class BookingStates {
  const BookingStates();
}

class BookingInitial extends BookingStates {
  const BookingInitial();
}

class BookingLoading extends BookingStates {
  const BookingLoading();
}

class BookingSuccess extends BookingStates {
  const BookingSuccess();
}

class BookingError extends BookingStates {
  final String message;
  const BookingError(this.message);
}

class BookingWalletChanged extends BookingStates {
  final String selectedWallet;
  const BookingWalletChanged(this.selectedWallet);
}

class CardSavingLoading extends BookingStates {
  const CardSavingLoading();
}

class CardSaved extends BookingStates {
  const CardSaved();
}
