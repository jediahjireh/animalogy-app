class ReadingProgress {
  final String packId;
  final int lastPageRead;
  final bool completed;

  const ReadingProgress({
    required this.packId,
    this.lastPageRead = 0,
    this.completed = false,
  });

  ReadingProgress copyWith({int? lastPageRead, bool? completed}) {
    return ReadingProgress(
      packId: packId,
      lastPageRead: lastPageRead ?? this.lastPageRead,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() => {
    'packId': packId,
    'lastPageRead': lastPageRead,
    'completed': completed,
  };

  factory ReadingProgress.fromJson(Map<String, dynamic> json) {
    return ReadingProgress(
      packId: json['packId'] as String,
      lastPageRead: json['lastPageRead'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
    );
  }
}
