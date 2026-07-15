import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _navigate);
  }

  void _navigate() {
    if (!mounted) return;
    final hasRegion = ref.read(hasSelectedRegionProvider);
    context.go(hasRegion ? '/' : '/region-selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AnimalColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                      width: Dimensions.iconXxl,
                      height: Dimensions.iconXxl,
                      decoration: BoxDecoration(
                        color: AnimalColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AnimalColors.primary.withValues(alpha: 0.3),
                          width: Dimensions.borderMd,
                        ),
                      ),
                      child: const Icon(
                        Icons.public,
                        size: Dimensions.iconLg,
                        color: AnimalColors.primary,
                      ),
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: Dimensions.lg),
                Text(
                      'Welcome to Animalogy',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AnimalColors.textPrimary,
                          ),
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),
                const SizedBox(height: Dimensions.sm),
                Text(
                      'Learn safety through stories from around the world',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AnimalColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
