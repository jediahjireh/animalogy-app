import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/regions.dart';
import '../../../core/l10n/ui_strings.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/region_icon.dart';

class RegionSelectionPage extends ConsumerWidget {
  const RegionSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AnimalColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Dimensions.xl),
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
              ),
              const SizedBox(height: Dimensions.md),
              Text(
                'Welcome to Animalogy',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AnimalColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.sm),
              Text(
                'Choose your region to meet your local animal guide',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AnimalColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.xl),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Dimensions.md,
                    mainAxisSpacing: Dimensions.md,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: Region.values.length,
                  itemBuilder: (context, index) {
                    final region = Region.values[index];
                    final mascot = MascotRegistry.getByRegion(region.id);
                    return _RegionGridCard(
                          region: region,
                          mascotName: mascot.name,
                          mascotIcon: mascot.icon,
                          mascotImageUrl: mascot.imageUrl,
                          onTap: () => _selectRegion(context, ref, region),
                        )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 100 * index),
                          duration: 400.ms,
                        )
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          delay: Duration(milliseconds: 100 * index),
                          duration: 400.ms,
                          curve: Curves.easeOutBack,
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectRegion(
    BuildContext context,
    WidgetRef ref,
    Region region,
  ) async {
    await ref.read(selectedRegionProvider.notifier).select(region);
    if (!context.mounted) return;

    final packs = StoryPackRegistry.getByRegion(region.id);
    final languages = <String>{};
    for (final pack in packs) {
      languages.addAll(pack.availableLanguages);
    }

    if (languages.length > 1) {
      await _showLanguagePicker(context, ref, region, languages.toList());
    } else {
      context.go('/');
    }
  }

  Future<void> _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    Region region,
    List<String> languages,
  ) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusXl),
        ),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AnimalColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.md),
              Icon(
                Icons.translate_rounded,
                size: Dimensions.iconLg,
                color: region.color,
              ),
              const SizedBox(height: Dimensions.sm),
              Text(
                'Choose your language',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.xs),
              Text(
                'Stories in ${region.name} are available in multiple languages',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AnimalColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.lg),
              ...languages.map(
                (langCode) => Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.sm),
                  child: CartoonButton(
                    label: UIStrings.languageName(langCode),
                    icon: Icons.language_rounded,
                    color: region.color,
                    expanded: true,
                    onPressed: () {
                      final packs = StoryPackRegistry.getByRegion(region.id);
                      for (final pack in packs) {
                        if (pack.hasLanguage(langCode)) {
                          ref
                              .read(packLanguageProvider.notifier)
                              .setLanguage(pack.id, langCode);
                        }
                      }
                      Navigator.pop(context);
                      context.go('/');
                    },
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.md),
            ],
          ),
        ),
      ),
    );

    // If user dismissed without picking, navigate to home with defaults
    if (context.mounted) context.go('/');
  }
}

class _RegionGridCard extends StatelessWidget {
  final Region region;
  final String mascotName;
  final IconData mascotIcon;
  final String mascotImageUrl;
  final VoidCallback onTap;

  const _RegionGridCard({
    required this.region,
    required this.mascotName,
    required this.mascotIcon,
    this.mascotImageUrl = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CartoonCard(
      borderColor: region.color,
      onTap: onTap,
      rotate: true,
      padding: const EdgeInsets.all(Dimensions.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RegionIcon(
            region: region,
            size: Dimensions.iconLg,
            showBackground: true,
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            region.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: region.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Dimensions.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (mascotImageUrl.isNotEmpty)
                ClipOval(
                  child: SizedBox(
                    width: Dimensions.iconSm + 4,
                    height: Dimensions.iconSm + 4,
                    child: Image.network(
                      mascotImageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        mascotIcon,
                        size: Dimensions.iconSm,
                        color: region.color,
                      ),
                    ),
                  ),
                )
              else
                Icon(mascotIcon, size: Dimensions.iconSm, color: region.color),
              const SizedBox(width: Dimensions.xs),
              Flexible(
                child: Text(
                  mascotName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AnimalColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            region.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AnimalColors.textTertiary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
