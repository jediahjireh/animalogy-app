import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/app_mode_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class AnimalologyApp extends ConsumerWidget {
  const AnimalologyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final appMode = ref.watch(appModeProvider);

    return MaterialApp.router(
      title: 'Animalogy',
      debugShowCheckedModeBanner: false,
      theme: AnimalTheme.light(mode: appMode),
      routerConfig: router,
    );
  }
}
