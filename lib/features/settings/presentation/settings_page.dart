import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../domain/models/app_mode.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final region = ref.watch(selectedRegionProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.md),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text('Educator Mode'),
              subtitle: Text(
                appMode == AppMode.educator
                    ? 'Full guides, activities, and discussion prompts visible'
                    : 'Simplified view optimized for children',
              ),
              value: appMode == AppMode.educator,
              activeTrackColor: AnimalColors.secondary.withValues(alpha: 0.5),
              activeThumbColor: AnimalColors.secondary,
              secondary: Icon(
                appMode == AppMode.educator ? Icons.school : Icons.child_care,
                color: appMode == AppMode.educator
                    ? AnimalColors.secondary
                    : AnimalColors.accent,
              ),
              onChanged: (_) => ref.read(appModeProvider.notifier).toggle(),
            ),
          ),
          const SizedBox(height: Dimensions.md),
          Card(
            child: ListTile(
              leading: Icon(
                region?.icon ?? Icons.public,
                color: region?.color ?? AnimalColors.primary,
              ),
              title: const Text('Region'),
              subtitle: Text(region?.name ?? 'Not selected'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showRegionPicker(context, ref, region),
            ),
          ),
          const SizedBox(height: Dimensions.xl),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Animalogy',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: Dimensions.sm),
                  Text(
                    'Animalogy teaches children about safety, trust, and '
                    'digital awareness through culturally-relevant animal '
                    'stories. Each story uses real animal behaviours to help '
                    'kids understand complex social situations in a way that '
                    'feels familiar and engaging.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: Dimensions.md),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegionPicker(BuildContext context, WidgetRef ref, Region? current) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Text(
                'Select Region',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...Region.values.map(
              (r) => ListTile(
                leading: Icon(r.icon, color: r.color),
                title: Text('${r.emoji} ${r.name}'),
                trailing: r == current
                    ? const Icon(Icons.check, color: AnimalColors.primary)
                    : null,
                onTap: () {
                  ref.read(selectedRegionProvider.notifier).select(r);
                  Navigator.pop(ctx);
                },
              ),
            ),
            const SizedBox(height: Dimensions.md),
          ],
        ),
      ),
    );
  }
}
