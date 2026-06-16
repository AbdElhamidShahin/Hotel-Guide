import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/faq_model.dart';
import 'faq_states.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(const FaqLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      // ✅ Fix: replaced hardcoded placeholder with real FAQ content
      emit(const FaqLoaded(_kFaqs));
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

// Static FAQ content — move to a remote config or CMS for easy updates
const List<FaqModel> _kFaqs = [
  FaqModel(
    id: 0,
    question: 'كيف يمكنني حجز غرفة فندقية؟',
    answer:
        'يمكنك البحث عن الفندق المناسب، اختيار الغرفة، تحديد تواريخ الإقامة، ثم إتمام الدفع عبر المحفظة الإلكترونية أو البطاقة البنكية.',
  ),
  FaqModel(
    id: 1,
    question: 'ما طرق الدفع المتاحة؟',
    answer:
        'ندعم الدفع عبر محفظة AQUA الإلكترونية والبطاقات البنكية (Visa / Mastercard) من خلال بوابة Stripe الآمنة.',
  ),
  FaqModel(
    id: 2,
    question: 'هل يمكنني إلغاء الحجز؟',
    answer:
        'نعم، يمكن إلغاء الحجز قبل 24 ساعة من موعد الوصول. يرجى التواصل مع الدعم الفني للمساعدة.',
  ),
  FaqModel(
    id: 3,
    question: 'كيف أشحن رصيد المحفظة؟',
    answer:
        'اذهب إلى صفحة المحفظة، اضغط "شحن رصيد"، أدخل المبلغ واتبع خطوات الدفع عبر بطاقتك البنكية.',
  ),
  FaqModel(
    id: 4,
    question: 'هل البيانات الشخصية محفوظة بأمان؟',
    answer:
        'نعم، نستخدم تشفير SSL وننتهج أفضل معايير الأمان لحماية بياناتك الشخصية ومعلومات الدفع.',
  ),
  FaqModel(
    id: 5,
    question: 'كيف أتواصل مع الدعم الفني؟',
    answer:
        'يمكنك التواصل معنا عبر صفحة "اتصل بنا" في القائمة الرئيسية، أو عبر البريد الإلكتروني support@aqua-hotels.com.',
  ),
];
