/// Localized version of comprehension question
class LocalizedComprehensionQuestion {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String mascotEncouragement;

  const LocalizedComprehensionQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.mascotEncouragement,
  });
}
