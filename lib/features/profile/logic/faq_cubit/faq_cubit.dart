import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/faq_model.dart';
import 'faq_states.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(const FaqLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(FaqLoaded(List.generate(
        10,
            (i) => FaqModel(
          id: i,
          question: 'مستقبل منصة ستاي إيجيبت',
          answer: 'نسعى إلى تطوير المنصة لتكون الوجهة الأولى للسياحة الداخلية في مصر.',
        ),
      )));
    } catch (e) {
      emit(FaqError(e.toString()));
    }
  }

  void toggle(int id) {
    if (state is! FaqLoaded) return;
    final faqs = (state as FaqLoaded).faqs.map((f) {
      if (f.id == id) return f.copyWith(isExpanded: !f.isExpanded);
      return f.copyWith(isExpanded: false);
    }).toList();
    emit(FaqLoaded(faqs));
  }
}