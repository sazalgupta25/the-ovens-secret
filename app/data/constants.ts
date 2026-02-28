// ============================================================================
// Business Information & Constants
// ============================================================================

export const businessInfo = {
  name: "The Ovens' Secret",
  baker: "Priya Gupta",
  phone: "9740264800",
  whatsapp: "9740264800",
  address: "406, Yamuna View Apartments, Agra",
  taglines: [
    "Freshly baked on the same day with no preservatives.",
    "Home delivery available within a 5 km radius.",
    "Theme based cakes available.",
  ],
};

// Social Media URLs
export const socialLinks = {
  facebook: "https://www.facebook.com/theovenssecret",
  instagram: "https://www.instagram.com/theovenssecret",
  twitter: "https://www.twitter.com/theovenssecret",
  whatsapp: `https://wa.me/91${businessInfo.whatsapp}?text=Hi! I'd like to place an order from The Ovens' Secret.`,
};

// Delivery Info
export const deliveryInfo = {
  radius: "5 km",
  baseAddress: businessInfo.address,
  minDeliveryTime: "same day",
  maxDeliveryTime: "24 hours",
};

// Color Palette (Tailwind)
export const colors = {
  primary: "#c0392b", // Red
  primaryHover: "#a93226",
  background: "#fdf6ee",
  text: "#5c2d1e",
  accent: "#7b1f1f",
  border: "#f0ddc0",
  light: "#faebd7",
};
