import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/menu_page.dart';
import '../pages/recipes_page.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: HomePage(),
      ),
    ),
    GoRoute(
      path: '/menu',
      pageBuilder: (context, state) {
        final categoryId = state.uri.queryParameters['id'];
        return NoTransitionPage(
          child: MenuPage(initialCategoryId: categoryId),
        );
      },
    ),
    GoRoute(
      path: '/recipes',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RecipesPage(),
      ),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AboutPage(),
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: ContactPage(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => NoTransitionPage(
    child: _NotFoundPage(),
  ),
);

class _NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w700,
                color: Color(0xFF78350F),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
