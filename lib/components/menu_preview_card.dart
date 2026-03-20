import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/menu_types.dart';

class MenuPreviewCard extends StatefulWidget {
  final MenuCategory category;

  const MenuPreviewCard({super.key, required this.category});

  @override
  State<MenuPreviewCard> createState() => _MenuPreviewCardState();
}

class _MenuPreviewCardState extends State<MenuPreviewCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go('/menu?id=${widget.category.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.12 : 0.05),
                blurRadius: _isHovered ? 24 : 12,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: _isHovered ? AppColors.amber300 : AppColors.amber100,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.amber50,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  widget.category.emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.category.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBurgundy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.category.sections.fold<int>(0, (sum, section) => sum + section.items.length)} Items',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.sienna,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _isHovered ? AppColors.primaryRed : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.primaryRed,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'View Menu',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _isHovered ? Colors.white : AppColors.primaryRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
