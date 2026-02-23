// =============================================================================
// menu.ts — Complete menu data for The Oven's Secret
// Source: Official menu PDF by Priya Gupta
// All prices in INR (₹). Serving sizes as specified per category.
// =============================================================================

export interface MenuItem {
  name: string;
  price: number; // in ₹
  priceNote?: string; // e.g., "per piece", "+ addon"
}

export interface MenuSection {
  title: string;
  servingSize?: string;
  items: MenuItem[];
  note?: string;
}

export interface MenuCategory {
  id: string;
  title: string;
  emoji: string;
  sections: MenuSection[];
}

// ---------------------------------------------------------------------------
// CAKES
// ---------------------------------------------------------------------------
const cakesCategory: MenuCategory = {
  id: "cakes",
  title: "Cakes",
  emoji: "🎂",
  sections: [
    {
      title: "The Classic Flavors",
      servingSize: "Each serving weighs 500 grams",
      items: [
        { name: "Vanilla Cake", price: 350 },
        { name: "Butterscotch Cake", price: 400 },
        { name: "Pineapple Cake", price: 350 },
        { name: "Strawberry Cake", price: 350 },
        { name: "Blueberry Cake", price: 350 },
        { name: "Black Forest Cake", price: 400 },
        { name: "Chocolate Caramel Cake", price: 450 },
        { name: "Chocolate Coffee Cake", price: 450 },
        { name: "Rasmalai Cake", price: 500 },
        { name: "Rose Pistachio Cake", price: 500 },
      ],
      note: "Design Add-ons: Different Design with Any Flavor +₹150 | Tiger Print Cake with Any Flavor +₹200",
    },
    {
      title: "Special Design Cakes",
      servingSize: "1 Kg",
      items: [
        { name: "Doll Cake", price: 1050 },
        { name: "Photo Print Cake", price: 1050 },
      ],
    },
    {
      title: "Chocolate Cakes",
      servingSize: "Each serving weighs 500 grams",
      items: [
        { name: "Snicker Cake", price: 600 },
        { name: "Death By Chocolate", price: 600 },
        { name: "Tiramisu Cake", price: 600 },
        { name: "Chocolate Caramel Cake", price: 600 },
        { name: "Nutella Chocolate Cake", price: 600 },
        { name: "Day and Night Cake", price: 600 },
        { name: "Choco Orange Cake", price: 600 },
        { name: "Choco Cherry Kit-Kat", price: 600 },
      ],
    },
    {
      title: "The Healthy Flavors",
      servingSize: "Each serving weighs 500 grams",
      items: [
        { name: "Choco Orange Whole Wheat", price: 500 },
        { name: "Multigrain Dates", price: 500 },
        { name: "Millet Choco Chips", price: 500 },
        { name: "Strawberry Bliss", price: 500 },
        { name: "Walnut Banana Wheat", price: 500 },
        { name: "Tutti-frutti Dry Fruit", price: 500 },
        { name: "Almond Cake", price: 500 },
        { name: "Oreo Chocolate Chunks", price: 500 },
        { name: "Dark Chocolate Quinoa", price: 500 },
        { name: "Nutty Pista Cake", price: 500 },
        { name: "Red Velvet Sorghum", price: 500 },
      ],
    },
  ],
};

// ---------------------------------------------------------------------------
// SPECIAL CAKES
// ---------------------------------------------------------------------------
const specialCakesCategory: MenuCategory = {
  id: "special-cakes",
  title: "Special Cakes",
  emoji: "✨",
  sections: [
    {
      title: "Mithai Dry Cakes",
      servingSize: "Each serving weighs 500 grams",
      items: [
        { name: "Boondi Ladoo", price: 550 },
        { name: "Peanut Chikki", price: 550 },
        { name: "Rasmalai", price: 550 },
        { name: "Rajbhog", price: 550 },
        { name: "Kaju Katli", price: 550 },
        { name: "Blueberry", price: 550 },
      ],
    },
    {
      title: "Teatime Cakes",
      servingSize: "Each serving weighs 500 grams",
      items: [
        { name: "Rose Pistachio", price: 500 },
        { name: "Banana Walnut", price: 500 },
        { name: "Chocolate Mud", price: 500 },
        { name: "Pound Cake", price: 500 },
        { name: "Oreo Cookie Cake", price: 500 },
        { name: "Coconut Cake", price: 500 },
        { name: "Blueberry Cake", price: 500 },
      ],
    },
  ],
};

// ---------------------------------------------------------------------------
// BROWNIES & BLONDIES
// ---------------------------------------------------------------------------
const browniesCategory: MenuCategory = {
  id: "brownies",
  title: "Brownies & Blondies",
  emoji: "🍫",
  sections: [
    {
      title: "Brownies & Blondies",
      servingSize: "Each serving weighs 100 grams",
      items: [
        { name: "Walnut Brownie", price: 200 },
        { name: "Peanut Butter Brownie", price: 200 },
        { name: "Crunchy Caramel Brownie", price: 200 },
        { name: "Mango Oreo Blondies", price: 200 },
        { name: "Strawberry Sandwich Blondies", price: 200 },
        { name: "Rock And Roll Blondies", price: 200 },
        { name: "Red Velvet Cheese Cream Blondies", price: 250 },
        { name: "Lemon Cheese Cream Blondies", price: 250 },
      ],
      note: "Additional Toppings: Nutella Spread +₹50 | Biscoff +₹50",
    },
  ],
};

// ---------------------------------------------------------------------------
// COOKIES
// ---------------------------------------------------------------------------
const cookiesCategory: MenuCategory = {
  id: "cookies",
  title: "Cookies & Others",
  emoji: "🍪",
  sections: [
    {
      title: "The Classic Cookies",
      servingSize: "Each serving weighs 200 grams",
      items: [
        { name: "Naankhatai", price: 180 },
        { name: "Choco Chips", price: 180 },
        { name: "Jeera", price: 180 },
        { name: "Coffee", price: 180 },
        { name: "Choco Ragi", price: 180 },
        { name: "Butter", price: 180 },
        { name: "Almond", price: 200 },
        { name: "Cashew", price: 220 },
        { name: "Choco Vanilla Animal Shape (Kids Favourite)", price: 200 },
      ],
      note:
        "Also available as Finger Stick Cookies @ ₹220 (250g) made with ghee & wheat flour — Wheat, Elaichi, Pineapple, Choco Ragi, Cashew, Pistachio, Almond",
    },
    {
      title: "The Healthy Cookies",
      servingSize: "Each serving weighs 200 grams",
      items: [
        { name: "Red Velvet Choco Chunk", price: 300 },
        { name: "Honey Lime Coconut", price: 300 },
        { name: "Peanut Butter Flaky", price: 300 },
        { name: "Oatmeal Choco Chips", price: 300 },
        { name: "Protein Pack Cookies", price: 300 },
        { name: "Banana Finger Millet", price: 300 },
        { name: "Pistachio Dual", price: 300 },
        { name: "Keto Cookies", price: 300 },
        { name: "Flax Chia Seed Cookies", price: 300 },
        { name: "Oats Sesame Cookies", price: 300 },
      ],
    },
    {
      title: "Flavored Makhana",
      servingSize: "Each serving weighs 60 grams",
      items: [
        { name: "Mint Makhana", price: 150 },
        { name: "Peri-Peri Makhana", price: 150 },
        { name: "Cheese Makhana", price: 150 },
        { name: "Caramel Makhana", price: 200 },
        { name: "Maggi Masala Makhana", price: 150 },
        { name: "Mint Cashew Makhana", price: 150 },
        { name: "Peri-Peri Cashew Makhana", price: 150 },
      ],
    },
  ],
};

// ---------------------------------------------------------------------------
// CHOCOLATES
// ---------------------------------------------------------------------------
const chocolatesCategory: MenuCategory = {
  id: "chocolates",
  title: "Chocolates",
  emoji: "🍬",
  sections: [
    {
      title: "Assorted Chocolates",
      servingSize: "Each serving weighs 100 grams",
      items: [
        { name: "Liquid Center Chocolate (Filled with Flavor)", price: 180 },
        { name: "Dry Fruit Chocolate", price: 250 },
        { name: "Dates Chocolate", price: 200 },
        { name: "Almond Chocolate", price: 200 },
        {
          name: "Oreo Lollipop Chocolate",
          price: 15,
          priceNote: "per piece",
        },
        { name: "Chocolate Coated Cashew", price: 250 },
        { name: "Chocolate Coated Almond", price: 250 },
        { name: "Crunchy Chocolate", price: 140 },
      ],
    },
  ],
};

// ---------------------------------------------------------------------------
// Full menu export
// ---------------------------------------------------------------------------
export const menu: MenuCategory[] = [
  cakesCategory,
  specialCakesCategory,
  browniesCategory,
  cookiesCategory,
  chocolatesCategory,
];

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
