import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../data/constants.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Container(
      color: AppColors.darkBrown,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1152),
        child: Column(
          children: [
            // 3-column layout
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 768) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BrandSection(),
                      const SizedBox(height: 24),
                      _QuickLinksSection(context),
                      const SizedBox(height: 24),
                      _ContactSection(),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _BrandSection()),
                    Expanded(child: _QuickLinksSection(context)),
                    Expanded(child: _ContactSection()),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.stone500),
            const SizedBox(height: 16),
            Text(
              '© $currentYear The Ovens Secret. All rights reserved.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.stone300,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _BrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Ovens Secret',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.stone300,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Exploring the art and science of artisan baking through time-honored techniques and innovative recipes.',
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.stone200),
        ),
      ],
    );
  }

  Widget _QuickLinksSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.stone300,
          ),
        ),
        const SizedBox(height: 8),
        _FooterLink(context, 'Home', '/'),
        _FooterLink(context, 'Recipes', '/recipes'),
        _FooterLink(context, 'About Us', '/about'),
      ],
    );
  }

  Widget _FooterLink(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => context.go(route),
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 13, color: AppColors.stone200),
          ),
        ),
      ),
    );
  }

  Widget _ContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.stone300,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Email: ${BusinessInfo.email}',
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.stone200),
        ),
        const SizedBox(height: 4),
        Text(
          'Follow us on social media',
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.stone200),
        ),
      ],
    );
  }
}
