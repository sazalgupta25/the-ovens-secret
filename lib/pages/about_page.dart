import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/header.dart';
import '../components/page_shell.dart';
import '../theme/app_theme.dart';
import '../data/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      slivers: [
        SliverToBoxAdapter(child: _AboutContent()),
      ],
    );
  }

  Widget _AboutContent() {
    return Container(
      color: AppColors.creamBackground,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderGold),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome to The Oven's Secret",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepBurgundy,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Baked with Love by ${BusinessInfo.baker}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    color: AppColors.sienna,
                  ),
                ),
                const SizedBox(height: 32),
                ..._paragraphs.map((text) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        text,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppColors.warmBrownText,
                          height: 1.7,
                        ),
                      ),
                    )),
                const SizedBox(height: 16),
                Text(
                  'With love,',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warmBrownText,
                  ),
                ),
                Text(
                  'Priya Gupta',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warmBrownText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<String> _paragraphs = [
    "Hello! I'm Priya Gupta, the heart and hands behind The Ovens Secret. For me, baking has never been just about flour and sugar; it's about love, family, and the joy of creating something beautiful for a special moment.",
    "It all started in my home kitchen, with a passion for creating delicious treats for my own family's celebrations. I discovered that a cake is more than just a dessert—it's a centerpiece for our happiest memories. It's the smile on a child's face, the shared slice at a family gathering, the sweet beginning to a new chapter.",
    'What started as a hobby has blossomed into a passion I\'m thrilled to share with you. "The Ovens Secret" isn\'t a factory; it\'s my home, my kitchen, and my commitment to quality. I use the same wholesome ingredients and time-tested recipes that my own family loves.',
    "As an FSSAI-registered home baker, I take pride in every detail, from our first conversation about your vision to the final, delicate touches on your cake. Thank you for letting me be a small part of your big moments. I can't wait to bake for you!",
  ];
}
