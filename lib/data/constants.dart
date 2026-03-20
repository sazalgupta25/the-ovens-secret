/// Business constants — identical to the Next.js data/constants.ts
class BusinessInfo {
  static const String name = "The Ovens' Secret";
  static const String baker = "Priya Gupta";
  static const String phone = "9740264800";
  static const String whatsapp = "9740264800";
  static const String address = "406, Yamuna View Apartments, Agra";
  static const String email = "info@theovens-secret.com";

  static const List<String> taglines = [
    "Freshly baked on the same day with no preservatives.",
    "Home delivery available within a 5 km radius.",
    "Theme based cakes available.",
  ];

  static String get whatsappOrderUrl =>
      'https://wa.me/91$whatsapp?text=${Uri.encodeComponent("Hi! I\'d like to place an order from The Ovens\' Secret.")}';

  static String get whatsappContactUrl =>
      'https://wa.me/91$whatsapp?text=${Uri.encodeComponent("Hi! I have a question about The Ovens\' Secret.")}';

  static String get phoneUrl => 'tel:+91$phone';
}

class SocialLinks {
  static const String facebook = "https://www.facebook.com/priyakakhazana";
  static const String instagram = "https://www.instagram.com/_the_ovens_secret/";
  static const String youtube = "https://www.youtube.com/c/priyakakhazana";
}
