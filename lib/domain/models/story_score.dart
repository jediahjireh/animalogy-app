class StoryScore {
  final String packId;
  final int correctAnswers;
  final int totalQuestions;
  final int stars;
  final DateTime completedAt;

  const StoryScore({
    required this.packId,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.stars,
    required this.completedAt,
  });

  static int calculateStars(int correct, int total) {
    if (total == 0) return 0;
    final ratio = correct / total;
    if (ratio >= 0.9) return 3;
    if (ratio >= 0.6) return 2;
    if (ratio >= 0.3) return 1;
    return 0;
  }

  Map<String, dynamic> toJson() => {
    'packId': packId,
    'correctAnswers': correctAnswers,
    'totalQuestions': totalQuestions,
    'stars': stars,
    'completedAt': completedAt.toIso8601String(),
  };

  factory StoryScore.fromJson(Map<String, dynamic> json) => StoryScore(
    packId: json['packId'] as String,
    correctAnswers: json['correctAnswers'] as int,
    totalQuestions: json['totalQuestions'] as int,
    stars: json['stars'] as int,
    completedAt: DateTime.parse(json['completedAt'] as String),
  );
}
