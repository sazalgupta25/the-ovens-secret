import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final currentRoute =
        GoRouterState.of(context).uri.toString();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBrown,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                // Logo + Brand name
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (_, __, ___) => const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.cake,
                                  color: AppColors.stone200, size: 32),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'The Ovens Secret',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.stone200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 32),

                // Desktop Nav
                if (!isMobile) ...[
                  Expanded(
                    child: Row(
                      children: [
                        _NavItem('Home', '/', currentRoute, context),
                        _NavItem('Menu', '/menu', currentRoute, context),
                        _NavItem('Recipes', '/recipes', currentRoute, context),
                        _NavItem('About', '/about', currentRoute, context),
                        _NavItem('Contact', '/contact', currentRoute, context),
                      ],
                    ),
                  ),
                ] else ...[
                  const Spacer(),
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu,
                          color: AppColors.stone200, size: 28),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _NavItem(
      String label, String route, String currentRoute, BuildContext context) {
    final isActive = currentRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => context.go(route),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.stone200,
            ),
          ),
        ),
      ),
    );
  }
}

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkBrown,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset('assets/images/logo.png',
                      width: 40,
                      height: 40,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.cake, color: AppColors.stone200)),
                  const SizedBox(width: 8),
                  Text(
                    'The Ovens Secret',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.stone200,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _DrawerItem(context, 'Home', '/', Icons.home_outlined),
            _DrawerItem(context, 'Menu', '/menu', Icons.restaurant_menu),
            _DrawerItem(context, 'Recipes', '/recipes', Icons.menu_book),
            _DrawerItem(context, 'About', '/about', Icons.info_outline),
            _DrawerItem(context, 'Contact', '/contact', Icons.mail_outline),
          ],
        ),
      ),
    );
  }

  Widget _DrawerItem(
      BuildContext context, String label, String route, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.stone200),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.stone200,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
}
