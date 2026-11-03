import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'app_routes.dart';
import 'app_shell.dart';
import 'auth_notifier.dart';
import 'error_404_page.dart';
import 'page_transitions.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  refreshListenable: authNotifier,
  errorBuilder: (context, state) => Error404Page(error: state.error),
  redirect: (context, state) {
    final isLoggingIn = state.matchedLocation == AppRoutes.login;
    final isAuthenticated = authNotifier.isAuthenticated;

    // If not authenticated and not currently going to login -> redirect to login
    if (!isAuthenticated && !isLoggingIn) {
      return AppRoutes.login;
    }

    // If already authenticated and trying to visit login -> redirect to home
    if (isAuthenticated && isLoggingIn) {
      return AppRoutes.home;
    }

    // No redirection needed
    return null;
  },
  routes: [
    // ── Fullscreen Auth Route ───────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        type: PageTransitionType.fade,
        child: const LoginPage(),
      ),
    ),

    // ── Shell Navigation Route (With BottomBar / NavigationRail) ───────────
    ShellRoute(
      builder: (context, state, child) => AppShell(state: state, child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            type: PageTransitionType.fade,
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            type: PageTransitionType.slideFromRight,
            child: const ProfilePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context,
            state: state,
            type: PageTransitionType.slideFromRight,
            child: const SettingsPage(),
          ),
        ),
      ],
    ),
  ],
);
