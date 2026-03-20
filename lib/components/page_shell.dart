import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'header.dart';
import 'footer.dart';
import '../data/constants.dart';
import '../theme/app_theme.dart';

/// Common page shell with Header + scrollable content + Footer
class PageShell extends StatelessWidget {
  final List<Widget> slivers;

  const PageShell({super.key, required this.slivers});

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
                ...slivers,
                SliverToBoxAdapter(child: const AppFooter()),
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
}
