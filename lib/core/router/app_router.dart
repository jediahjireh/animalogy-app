import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/region_provider.dart';
import 'route_names.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/region_selection/presentation/region_selection_page.dart';
import '../../features/story_browser/presentation/story_browser_page.dart';
import '../../features/story_browser/presentation/story_pack_detail_page.dart';
import '../../features/story_viewer/presentation/story_viewer_page.dart';
import '../../features/educator_guide/presentation/educator_guide_page.dart';
import '../../features/my_library/presentation/my_library_page.dart';
import '../../features/mascot_profiles/presentation/mascot_gallery_page.dart';
import '../../features/mascot_profiles/presentation/mascot_detail_page.dart';
import '../../features/skills_registry/presentation/skills_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../shared/widgets/app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final hasRegion = ref.watch(hasSelectedRegionProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: hasRegion ? '/' : '/region-selection',
    routes: [
      GoRoute(
        path: '/region-selection',
        name: RouteNames.regionSelection,
        builder: (context, state) => const RegionSelectionPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: RouteNames.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/browse',
            name: RouteNames.storyBrowser,
            builder: (context, state) => const StoryBrowserPage(),
          ),
          GoRoute(
            path: '/library',
            name: RouteNames.myLibrary,
            builder: (context, state) => const MyLibraryPage(),
          ),
          GoRoute(
            path: '/mascots',
            name: RouteNames.mascotGallery,
            builder: (context, state) => const MascotGalleryPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/browse/:packId',
        name: RouteNames.storyPackDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            StoryPackDetailPage(packId: state.pathParameters['packId']!),
      ),
      GoRoute(
        path: '/browse/:packId/read',
        name: RouteNames.storyViewer,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            StoryViewerPage(packId: state.pathParameters['packId']!),
      ),
      GoRoute(
        path: '/browse/:packId/guide',
        name: RouteNames.educatorGuide,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            EducatorGuidePage(packId: state.pathParameters['packId']!),
      ),
      GoRoute(
        path: '/mascots/:mascotId',
        name: RouteNames.mascotDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            MascotDetailPage(mascotId: state.pathParameters['mascotId']!),
      ),
      GoRoute(
        path: '/skills',
        name: RouteNames.skillsRegistry,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SkillsPage(),
      ),
      GoRoute(
        path: '/settings',
        name: RouteNames.settings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
});
