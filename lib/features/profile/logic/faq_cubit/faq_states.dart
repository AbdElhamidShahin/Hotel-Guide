import '../../data/model/faq_model.dart';

sealed class FaqState {
  const FaqState();
}

class FaqLoading extends FaqState {
  const FaqLoading();
}

class FaqLoaded extends FaqState {
  final List<FaqModel> faqs;
  const FaqLoaded(this.faqs);
}

class FaqError extends FaqState {
  final String message;
  const FaqError(this.message);
}