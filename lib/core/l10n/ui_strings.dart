class UIStrings {
  final String correct;
  final String notQuite;
  final String continueButton;
  final String storyComplete;
  final String backToStories;
  final String readAgain;
  final String correctLabel;
  final String says;
  final String starMessage3;
  final String starMessage2;
  final String starMessage1;
  final String starMessage0;

  const UIStrings._({
    required this.correct,
    required this.notQuite,
    required this.continueButton,
    required this.storyComplete,
    required this.backToStories,
    required this.readAgain,
    required this.correctLabel,
    required this.says,
    required this.starMessage3,
    required this.starMessage2,
    required this.starMessage1,
    required this.starMessage0,
  });

  static const _en = UIStrings._(
    correct: 'Correct!',
    notQuite: 'Not quite!',
    continueButton: 'Continue',
    storyComplete: 'Story Complete!',
    backToStories: 'Back to Stories',
    readAgain: 'Read Again',
    correctLabel: 'correct',
    says: 'says:',
    starMessage3: 'Amazing work! You got every question right!',
    starMessage2: 'Great job! You understood the story well!',
    starMessage1: 'Good effort! Try reading again to learn even more!',
    starMessage0: 'Keep practising! Every story teaches something new!',
  );

  static const _af = UIStrings._(
    correct: 'Korrek!',
    notQuite: 'Nie heeltemal nie!',
    continueButton: 'Gaan voort',
    storyComplete: 'Storie voltooi!',
    backToStories: 'Terug na stories',
    readAgain: 'Lees weer',
    correctLabel: 'korrek',
    says: 'sê:',
    starMessage3: 'Fantastiese werk! Jy het elke vraag reg beantwoord!',
    starMessage2: 'Goeie werk! Jy het die storie goed verstaan!',
    starMessage1: 'Goeie poging! Lees weer om nog meer te leer!',
    starMessage0: 'Hou aan oefen! Elke storie leer jou iets nuuts!',
  );

  static const _ro = UIStrings._(
    correct: 'Corect!',
    notQuite: 'Nu chiar!',
    continueButton: 'Continuă',
    storyComplete: 'Poveste terminată!',
    backToStories: 'Înapoi la povești',
    readAgain: 'Citește din nou',
    correctLabel: 'corecte',
    says: 'spune:',
    starMessage3: 'Excelent! Ai răspuns corect la fiecare întrebare!',
    starMessage2: 'Bravo! Ai înțeles bine povestea!',
    starMessage1: 'Bine lucrat! Citește din nou pentru a învăța și mai mult!',
    starMessage0: 'Continuă să exersezi! Fiecare poveste te învață ceva nou!',
  );

  static const _map = <String, UIStrings>{'en': _en, 'af': _af, 'ro': _ro};

  static UIStrings of(String? languageCode) =>
      _map[languageCode ?? 'en'] ?? _en;

  String starMessage(int stars) => switch (stars) {
    3 => starMessage3,
    2 => starMessage2,
    1 => starMessage1,
    _ => starMessage0,
  };

  String saysQuote(String name, String quote) => '$name $says "$quote"';

  static const languageNames = <String, String>{
    'en': 'English',
    'af': 'Afrikaans',
    'ro': 'Română',
  };

  static String languageName(String code) => languageNames[code] ?? code;
}
