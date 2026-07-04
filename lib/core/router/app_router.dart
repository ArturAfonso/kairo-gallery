import 'package:go_router/go_router.dart';
import 'package:kairo_gallery/core/di/injection.dart';
import 'package:kairo_gallery/core/router/app_routes.dart';
import 'package:kairo_gallery/core/router/go_router_refresh_stream.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/cubit/auth_lock_cubit.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/pages/lock_screen_.dart';
import 'package:kairo_gallery/features/favorites/presentation/pages/favorites_page.dart';
import 'package:kairo_gallery/features/gallery/presentation/pages/gallery_page.dart';
import 'package:kairo_gallery/features/home/presentation/pages/home_shell_page.dart';
import 'package:kairo_gallery/features/settings/presentation/pages/settings_page.dart';
import 'package:kairo_gallery/features/trash/presentation/pages/trash_page.dart';

/* final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.HOME,
  routes: [
    GoRoute(path: AppRoutes.HOME, name: 'home', builder: (context, state) => const HomeShellPage()),
    GoRoute(path: AppRoutes.FAVORITES, name: 'favorites', builder: (context, state) => const FavoritesPage()),
    GoRoute(path: AppRoutes.GALLERY_PAGE, name: 'gallery', builder: (context, state) => const GalleryPage()),
  ],
); */
final authCubit = sl<AuthLockCubit>();
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.gallery,
  refreshListenable: GoRouterRefreshStream(authCubit.stream),
  redirect: (context, state) {
    final isUnlocked = authCubit.state.isUnlocked;
    final isGoingToLock = state.matchedLocation == AppRoutes.lock;

    if (!isUnlocked && !isGoingToLock) {
      return AppRoutes.lock;
    }
    if (isUnlocked && isGoingToLock) {
      return AppRoutes.gallery;
    }
    return null; // sem redirect, segue pra rota pedida
  },
  routes: [
    GoRoute(path: AppRoutes.lock, name: 'lock', builder: (context, state) => const LockScreenPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeShellPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: AppRoutes.gallery, name: 'gallery', builder: (context, state) => GalleryPage())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: AppRoutes.favorites, name: 'favorites', builder: (context, state) => const FavoritesPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: AppRoutes.trash, name: 'Lixeira', builder: (context, state) => const TrashPage())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: AppRoutes.settings, name: 'settings', builder: (context, state) => const SettingsPage()),
          ],
        ),
      ],
    ),
  ],
);
