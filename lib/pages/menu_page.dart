import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/header.dart';
import '../theme/app_theme.dart';
import '../data/menu_data.dart';
import '../data/menu_types.dart';
import '../data/constants.dart';

class MenuPage extends StatefulWidget {
  final String? initialCategoryId;
  const MenuPage({super.key, this.initialCategoryId});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late String _activeCategory;

  @override
  void initState() {
    super.initState();
    _activeCategory = widget.initialCategoryId ?? menu[0].id;
  }

  MenuCategory get _currentCategory =>
      menu.firstWhere((c) => c.id == _activeCategory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MobileDrawer(),
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Hero
                SliverToBoxAdapter(child: _HeroSection()),
                // Category Tabs
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabHeaderDelegate(
                    categories: menu,
                    activeId: _activeCategory,
                    onSelect: (id) => setState(() => _activeCategory = id),
                  ),
                ),
                // Menu Content
                SliverToBoxAdapter(child: _MenuContent()),
                // Footer
                SliverToBoxAdapter(child: _MenuFooter()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final uri = Uri.parse('https://wa.me/91${BusinessInfo.whatsapp}');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        backgroundColor: AppColors.whatsAppGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text(
          'Chat on WhatsApp',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _HeroSection() {
    // Brand colors from logo: warm orange (#D4783E), deep burgundy (#7B2D2D)
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7B3F1D), // Warm dark brown (from logo outer ring)
            Color(0xFF8B4513), // Saddle brown
            Color(0xFF6B2020), // Deep burgundy (from logo text color)
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Stack(
        children: [
          // Decorative circles - subtle and non-intrusive
          Positioned(
            top: -32,
            left: -32,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -24,
            right: -24,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'BY ${BusinessInfo.baker.toUpperCase()}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                    color: const Color(0xFFF5D0B0), // Warm peach for readability
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Our Menu',
                  style: GoogleFonts.inter(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Freshly baked on the same day · No preservatives · Home delivery within 5 km',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFFECC8A8), // Warm cream for subtitle
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(
                        'https://wa.me/91${BusinessInfo.whatsapp}');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: const Icon(Icons.chat, size: 16),
                  label: Text(
                    'Order on WhatsApp',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7B3F1D),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _MenuContent() {
    final cat = _currentCategory;
    return Container(
      color: AppColors.creamBackground,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Category title
              Row(
                children: [
                  Text(cat.emoji, style: const TextStyle(fontSize: 36)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cat.title,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.deepBurgundy,
                        ),
                      ),
                      Text(
                        '${cat.sections.length} section${cat.sections.length > 1 ? "s" : ""} · ${cat.sections.fold<int>(0, (sum, s) => sum + s.items.length)} items',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.sienna,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Sections in 2-column grid on desktop
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700) {
                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: cat.sections.map((section) {
                        final fullWidth = section.items.length > 8;
                        return SizedBox(
                          width: fullWidth
                              ? constraints.maxWidth
                              : (constraints.maxWidth - 24) / 2,
                          child: _MenuSectionCard(section),
                        );
                      }).toList(),
                    );
                  }
                  return Column(
                    children: cat.sections
                        .map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: _MenuSectionCard(s),
                            ))
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _MenuSectionCard(MenuSection section) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGold),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section header
          Container(
            color: AppColors.primaryRed,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                if (section.servingSize != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text('🥐 ', style: TextStyle(fontSize: 12)),
                      Text(
                        section.servingSize!,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          // Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: section.items.asMap().entries.map((entry) {
                final isLast = entry.key == section.items.length - 1;
                return _MenuItemRow(entry.value, isLast);
              }).toList(),
            ),
          ),
          // Note
          if (section.note != null)
            Container(
              color: AppColors.lightAmber,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📌 Note: ',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.saddleBrown,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      section.note!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.saddleBrown,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _MenuItemRow(MenuItem item, bool isLast) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(
                  color: AppColors.borderRich,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.name,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.warmBrownText,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹${item.price.toString()}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryRed,
                ),
              ),
              if (item.priceNote != null)
                Text(
                  '/${item.priceNote}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.sienna,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _MenuFooter() {
    return Container(
      color: AppColors.deepBurgundy,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Text(
                BusinessInfo.name,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                BusinessInfo.baker,
                style: GoogleFonts.inter(
                    fontSize: 14, color: AppColors.pinkAccent),
              ),
              Text(
                BusinessInfo.address,
                style: GoogleFonts.inter(
                    fontSize: 14, color: AppColors.pinkAccent),
              ),
              const SizedBox(height: 8),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse(BusinessInfo.phoneUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  child: Text(
                    '📞 ${BusinessInfo.phone}',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...BusinessInfo.taglines.map((t) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      t,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: AppColors.pinkAccent),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Sticky Tab Header Delegate
// ============================================================================
class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<MenuCategory> categories;
  final String activeId;
  final ValueChanged<String> onSelect;

  _TabHeaderDelegate({
    required this.categories,
    required this.activeId,
    required this.onSelect,
  });

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamBackground,
        border: Border(
          bottom: BorderSide(color: AppColors.borderRich),
        ),
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: categories.map((cat) {
                final isActive = cat.id == activeId;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onSelect(cat.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryRed
                              : Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: isActive
                              ? null
                              : Border.all(color: AppColors.borderAmber),
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color:
                                        AppColors.primaryRed.withValues(alpha: 0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(cat.emoji,
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              cat.title,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isActive
                                    ? Colors.white
                                    : AppColors.warmBrownText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_TabHeaderDelegate oldDelegate) =>
      activeId != oldDelegate.activeId;
}
