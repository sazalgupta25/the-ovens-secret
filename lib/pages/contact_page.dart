import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/page_shell.dart';
import '../theme/app_theme.dart';
import '../data/constants.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      slivers: [
        SliverToBoxAdapter(child: _ContactContent(context)),
      ],
    );
  }

  Widget _ContactContent(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Us',
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.amber900,
                ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 768) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _ContactInfo()),
                        const SizedBox(width: 48),
                        Expanded(child: _WhatsAppSection()),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ContactInfo(),
                      const SizedBox(height: 32),
                      _WhatsAppSection(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.amber900,
          ),
        ),
        const SizedBox(height: 24),

        // Email
        Text(
          'Email',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.amber900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          BusinessInfo.email,
          style: GoogleFonts.inter(fontSize: 15, color: AppColors.gray600),
        ),
        const SizedBox(height: 24),

        // Address
        Text(
          'Address',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.amber900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          BusinessInfo.address,
          style: GoogleFonts.inter(fontSize: 15, color: AppColors.gray600),
        ),
        const SizedBox(height: 24),

        // Phone
        Text(
          'Phone',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.amber900,
          ),
        ),
        const SizedBox(height: 4),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              final uri = Uri.parse(BusinessInfo.phoneUrl);
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            child: Text(
              '+91 ${BusinessInfo.phone}',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Social
        Text(
          'Follow Us',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.amber900,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: [
            _SocialLink('Facebook', SocialLinks.facebook),
            _SocialLink('Instagram', SocialLinks.instagram),
            _SocialLink('Youtube', SocialLinks.youtube),
          ],
        ),
      ],
    );
  }

  Widget _SocialLink(String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.amber900,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _WhatsAppSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.creamBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGold),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Send Us a Message',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.amber900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Want to place a custom order, ask a question, or just say hello? Reach out to us directly on WhatsApp — we\'d love to hear from you!',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.warmBrownText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(BusinessInfo.whatsappContactUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.chat, size: 20),
              label: Text(
                'Chat on WhatsApp',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whatsAppGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Or call us at +91 ${BusinessInfo.phone}',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.gray600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
