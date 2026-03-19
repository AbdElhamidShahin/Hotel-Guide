class FaqModel {
  final int id;
  final String question;
  final String answer;
  final bool isExpanded;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  FaqModel copyWith({bool? isExpanded}) => FaqModel(
    id: id,
    question: question,
    answer: answer,
    isExpanded: isExpanded ?? this.isExpanded,
  );
}