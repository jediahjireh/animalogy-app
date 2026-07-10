enum AgeGroup {
  preschool(label: '4-6', displayName: 'Preschool', minAge: 4, maxAge: 6),
  earlyPrimary(
    label: '7-9',
    displayName: 'Early Primary',
    minAge: 7,
    maxAge: 9,
  ),
  latePrimary(
    label: '10-12',
    displayName: 'Late Primary',
    minAge: 10,
    maxAge: 12,
  );

  const AgeGroup({
    required this.label,
    required this.displayName,
    required this.minAge,
    required this.maxAge,
  });

  final String label;
  final String displayName;
  final int minAge;
  final int maxAge;
}
