import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/layout/app_bottom_nav.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/menu/presentation/mock/customize_mock.dart';
import '../../features/menu/presentation/pages/menu_customize_page.dart';
import '../../features/menu/presentation/pages/menu_detail_page.dart';
import '../../features/placeholder/presentation/placeholder_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.orders,
              builder: (context, state) => const PlaceholderPage(
                title: 'Pesanan',
                icon: Icons.receipt_long_outlined,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.menuDetail,
      redirect: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return customizeById(id) != null ? AppRoutes.customizePath(id) : null;
      },
      builder: (context, state) =>
          MenuDetailPage(id: state.pathParameters['id'] ?? ''),
    ),
    GoRoute(
      path: AppRoutes.menuCustomize,
      redirect: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return customizeById(id) == null ? AppRoutes.menuPath(id) : null;
      },
      builder: (context, state) =>
          MenuCustomizePage(id: state.pathParameters['id'] ?? ''),
    ),
    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: AppRoutes.orderTracking,
      builder: (context, state) => const PlaceholderScreen(
        title: 'Status Pesanan',
        icon: Icons.delivery_dining_rounded,
      ),
    ),
    GoRoute(
      path: AppRoutes.profileEdit,
      builder: (context, state) => const EditProfilePage(),
    ),
  ],
);

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
