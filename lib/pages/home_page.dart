import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:ui';
import '../components/page_shell.dart';
import '../components/menu_preview_card.dart';
import '../theme/app_theme.dart';
import '../data/constants.dart';
import '../data/menu_data.dart';
import '../data/feedback_model.dart';
import '../services/feedback_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      slivers: [
        // Hero Section
        SliverToBoxAdapter(child: _HeroSection(context)),
        // Menu Categories
        SliverToBoxAdapter(child: _MenuCategoriesSection(context)),
        // About Preview
        SliverToBoxAdapter(child: _AboutPreview(context)),
        // Gallery
        SliverToBoxAdapter(child: _GallerySection()),
        // How to Order
        SliverToBoxAdapter(child: _HowToOrder()),
        // Testimonials
        SliverToBoxAdapter(child: _TestimonialsSection()),
        // CTA
        SliverToBoxAdapter(child: _CtaSection()),
      ],
    );
  }

  Widget _HeroSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.amber50, AppColors.orange50],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              Text(
                'From Our Oven to Your Celebration',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: AppColors.deepBurgundy,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Handcrafted, personalized cakes and treats baked with love by Priya Gupta. Let\'s make your special moments a little sweeter.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: AppColors.sienna,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/menu'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 6,
                ),
                child: Text(
                  'Explore Our Creations',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _AboutPreview(BuildContext context) {
    return Container(
      color: AppColors.creamBackground,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Baked with Love by Priya',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBurgundy,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Hello! I\'m Priya Gupta, the heart and hands behind The Ovens Secret. For me, baking has never been just about flour and sugar; it\'s about love, family, and the joy of creating something beautiful for a special moment.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  color: AppColors.warmBrownText,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () => context.go('/about'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryRed,
                  side: const BorderSide(color: AppColors.primaryRed, width: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Read Our Story',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _GallerySection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: Column(
            children: [
              Text(
                'A Glimpse of Our Creations',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBurgundy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap an image to see it in full',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.sienna,
                ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 500
                          ? 2
                          : 1;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(6, (index) {
                      final imagePath =
                          'assets/images/cake/cake${index + 1}.png';
                      final itemWidth =
                          (constraints.maxWidth - (crossAxisCount - 1) * 16) /
                              crossAxisCount;
                      return GestureDetector(
                        onTap: () => _showFullImage(context, index),
                        child: SizedBox(
                          width: itemWidth,
                          height: 256,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Blurred background to fill space
                                Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox.shrink(),
                                ),
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    color: Colors.black.withValues(alpha: 0.1),
                                  ),
                                ),
                                // Uncropped image on top
                                Image.asset(
                                  imagePath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => Center(
                                    child: Icon(Icons.cake,
                                        size: 48, color: AppColors.sienna),
                                  ),
                                ),
                                // View Icon Overlay (Subtle)
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.zoom_in,
                                        size: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                'For more beautiful cakes, check out our Instagram!',
                style: GoogleFonts.inter(
                  fontSize: 17,
                  color: AppColors.warmBrownText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: 6,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    AssetImage('assets/images/cake/cake${index + 1}.png'),
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: 'cake-$index'),
              );
            },
            onPageChanged: (index) {},
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
            pageController: PageController(initialPage: initialIndex),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _HowToOrder() {
    return Container(
      color: AppColors.creamBackground,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'How to Order Your Custom Cake',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBurgundy,
                ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final items = [
                    _OrderStep(
                      '1. Get in Touch',
                      'Send us a message on WhatsApp or give us a call to discuss your ideas.',
                    ),
                    _OrderStep(
                      '2. Design Your Cake',
                      'We\'ll work with you to design the perfect cake for your occasion.',
                    ),
                    _OrderStep(
                      '3. Celebrate!',
                      'Your custom cake will be ready for pickup or delivery on your special day.',
                    ),
                  ];
                  if (constraints.maxWidth > 600) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: items
                          .map((w) => Expanded(child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: w,
                              )))
                          .toList(),
                    );
                  }
                  return Column(children: items);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _OrderStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryRed,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.warmBrownText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _TestimonialsSection() {
    final feedbackService = FeedbackService();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.amber50, AppColors.orange50],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'What Our Customers Say',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBurgundy,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your feedback makes our day! Share your experience with us.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.sienna,
                ),
              ),
              const SizedBox(height: 32),
              _WriteReviewButton(),
              const SizedBox(height: 48),
              StreamBuilder<List<CustomerFeedback>>(
                stream: feedbackService.getFeedbackStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryRed));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        _TestimonialCard(
                          '"The cake was not only beautiful but absolutely delicious! Priya is a true artist."',
                          '- A Happy Customer',
                        ),
                        const SizedBox(height: 16),
                        _TestimonialCard(
                          '"I ordered a custom cake for my daughter\'s birthday and it was the highlight of the party. Thank you, Priya!"',
                          '- Another Satisfied Client',
                        ),
                      ],
                    );
                  }

                  final feedbacks = snapshot.data!;
                  return Column(
                    children: feedbacks.map((feedback) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _TestimonialCard(
                          '"${feedback.quote}"',
                          '- ${feedback.author}',
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _WriteReviewButton() {
    return Builder(builder: (context) {
      return ElevatedButton.icon(
        onPressed: () => _showFeedbackDialog(context),
        icon: const Icon(Icons.edit_note, size: 20),
        label: Text(
          'Share Your Experience',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepBurgundy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 4,
        ),
      );
    });
  }

  void _showFeedbackDialog(BuildContext context) {
    final nameController = TextEditingController();
    final quoteController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Text(
          'Share Your Feedback',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: AppColors.deepBurgundy,
          ),
        ),
        content: Container(
          width: 400,
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    labelStyle: GoogleFonts.inter(color: AppColors.sienna),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryRed),
                    ),
                    prefixIcon: const Icon(Icons.person_outline,
                        color: AppColors.sienna),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: quoteController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Your Experience',
                    alignLabelWithHint: true,
                    labelStyle: GoogleFonts.inter(color: AppColors.sienna),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryRed),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 60.0),
                      child: Icon(Icons.chat_bubble_outline,
                          color: AppColors.sienna),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please share your thoughts' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: AppColors.sienna)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final user = FirebaseAuth.instance.currentUser;
                
                if (user == null) {
                   scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Please wait for auth...')),
                  );
                  return;
                }

                // Cyber-attack Guardrail 1: Local Rate Limiting
                final prefs = await SharedPreferences.getInstance();
                final lastSubmit = prefs.getInt('last_feedback_submit') ?? 0;
                final now = DateTime.now().millisecondsSinceEpoch;
                
                // 1 minute timeout
                if (now - lastSubmit < 60000) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text('Please wait a minute before submitting again!',
                          style: GoogleFonts.inter()),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                final feedback = CustomerFeedback(
                  author: nameController.text.trim(),
                  quote: quoteController.text.trim(),
                  date: DateTime.now(),
                  userId: user.uid,
                );
                
                // Guardrail 2: Security & Overwriting
                // We use user.uid to store the document, ensuring 1 user = 1 review.
                // This prevents spam as multiple submits just update the same record.
                await FirebaseFirestore.instance
                    .collection('customer_feedback')
                    .doc(user.uid)
                    .set(feedback.toJson());

                // Store last submit time
                await prefs.setInt('last_feedback_submit', now);
                
                navigator.pop();
                
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Thank you! Your experience has been saved.',
                        style: GoogleFonts.inter()),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text('Submit Review',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _TestimonialCard(String quote, String author) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            quote,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: AppColors.warmBrownText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            author,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.amber800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _MenuCategoriesSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: Column(
            children: [
              Text(
                'Explore Our Specialties',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBurgundy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Handcrafted treats for every mood and occasion',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.sienna,
                ),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                          ? 2
                          : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      return MenuPreviewCard(category: menu[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _CtaSection() {
    return Container(
      color: AppColors.primaryRed,
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          children: [
            Text(
              'Have a Special Occasion Coming Up?',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Let\'s create a cake that tells your story. For custom orders, questions, or just to say hello, get in touch with Priya.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 17,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse(BusinessInfo.whatsappOrderUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryRed,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Order Your Custom Cake',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
