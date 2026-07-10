enum AppMode {
  child,
  educator;

  String get displayName => switch (this) {
    AppMode.child => 'Child Mode',
    AppMode.educator => 'Educator Mode',
  };
}
