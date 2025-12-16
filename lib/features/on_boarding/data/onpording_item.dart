class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    image: 'assets/Onpording/OnPoarding1.jpg',
    title: 'اكتشف وجهتك المثالية بسهولة',
    description: 'استكشف أفضل الفنادق واختر مكان الإقامة الذي يناسبك في ثواني.',
  ),
  OnboardingContent(
    image: 'assets/Onpording/OnPoarding2.jpg',
    title: 'واجهة إحترافية وسهلة الاستخدام',
    description:
        'تجربة سلسة وتناسب كل الأذواق مع ذكاء اصطناعي للإجابة على تساؤلاتك.',
  ),
  OnboardingContent(
    image: 'assets/Onpording/OnPoarding3.jpg',
    title: 'حجز سريع - دفع آمن',
    description: 'ادفع بسهولة عبر بطاقتك البنكية أو محافظك الإلكترونية.',
  ),
];
