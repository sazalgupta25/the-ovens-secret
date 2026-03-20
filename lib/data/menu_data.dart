import 'menu_types.dart';

/// Complete menu data — ported exactly from Next.js categories/*.ts

const List<MenuCategory> menu = [
  // =========================================================================
  // CAKES
  // =========================================================================
  MenuCategory(
    id: 'cakes',
    title: 'Cakes',
    emoji: '🎂',
    sections: [
      MenuSection(
        title: 'The Classic Flavors',
        servingSize: 'Each serving weighs 500 grams',
        items: [
          MenuItem(name: 'Vanilla Cake', price: 350),
          MenuItem(name: 'Butterscotch Cake', price: 400),
          MenuItem(name: 'Pineapple Cake', price: 350),
          MenuItem(name: 'Strawberry Cake', price: 350),
          MenuItem(name: 'Blueberry Cake', price: 350),
          MenuItem(name: 'Black Forest Cake', price: 400),
          MenuItem(name: 'Chocolate Caramel Cake', price: 450),
          MenuItem(name: 'Chocolate Coffee Cake', price: 450),
          MenuItem(name: 'Rasmalai Cake', price: 500),
          MenuItem(name: 'Rose Pistachio Cake', price: 500),
        ],
        note:
            'Design Add-ons: Different Design with Any Flavor +₹150 | Tiger Print Cake with Any Flavor +₹200',
      ),
      MenuSection(
        title: 'Special Design Cakes',
        servingSize: '1 Kg',
        items: [
          MenuItem(name: 'Doll Cake', price: 1050),
          MenuItem(name: 'Photo Print Cake', price: 1050),
        ],
      ),
      MenuSection(
        title: 'Chocolate Cakes',
        servingSize: 'Each serving weighs 500 grams',
        items: [
          MenuItem(name: 'Snicker Cake', price: 600),
          MenuItem(name: 'Death By Chocolate', price: 600),
          MenuItem(name: 'Tiramisu Cake', price: 600),
          MenuItem(name: 'Chocolate Caramel Cake', price: 600),
          MenuItem(name: 'Nutella Chocolate Cake', price: 600),
          MenuItem(name: 'Day and Night Cake', price: 600),
          MenuItem(name: 'Choco Orange Cake', price: 600),
          MenuItem(name: 'Choco Cherry Kit-Kat', price: 600),
        ],
      ),
      MenuSection(
        title: 'The Healthy Flavors',
        servingSize: 'Each serving weighs 500 grams',
        items: [
          MenuItem(name: 'Choco Orange Whole Wheat', price: 500),
          MenuItem(name: 'Multigrain Dates', price: 500),
          MenuItem(name: 'Millet Choco Chips', price: 500),
          MenuItem(name: 'Strawberry Bliss', price: 500),
          MenuItem(name: 'Walnut Banana Wheat', price: 500),
          MenuItem(name: 'Tutti-frutti Dry Fruit', price: 500),
          MenuItem(name: 'Almond Cake', price: 500),
          MenuItem(name: 'Oreo Chocolate Chunks', price: 500),
          MenuItem(name: 'Dark Chocolate Quinoa', price: 500),
          MenuItem(name: 'Nutty Pista Cake', price: 500),
          MenuItem(name: 'Red Velvet Sorghum', price: 500),
        ],
      ),
    ],
  ),

  // =========================================================================
  // SPECIAL CAKES
  // =========================================================================
  MenuCategory(
    id: 'special-cakes',
    title: 'Special Cakes',
    emoji: '✨',
    sections: [
      MenuSection(
        title: 'Mithai Dry Cakes',
        servingSize: 'Each serving weighs 500 grams',
        items: [
          MenuItem(name: 'Boondi Ladoo', price: 550),
          MenuItem(name: 'Peanut Chikki', price: 550),
          MenuItem(name: 'Rasmalai', price: 550),
          MenuItem(name: 'Rajbhog', price: 550),
          MenuItem(name: 'Kaju Katli', price: 550),
          MenuItem(name: 'Blueberry', price: 550),
        ],
      ),
      MenuSection(
        title: 'Teatime Cakes',
        servingSize: 'Each serving weighs 500 grams',
        items: [
          MenuItem(name: 'Rose Pistachio', price: 500),
          MenuItem(name: 'Banana Walnut', price: 500),
          MenuItem(name: 'Chocolate Mud', price: 500),
          MenuItem(name: 'Pound Cake', price: 500),
          MenuItem(name: 'Oreo Cookie Cake', price: 500),
          MenuItem(name: 'Coconut Cake', price: 500),
          MenuItem(name: 'Blueberry Cake', price: 500),
        ],
      ),
    ],
  ),

  // =========================================================================
  // BROWNIES & BLONDIES
  // =========================================================================
  MenuCategory(
    id: 'brownies',
    title: 'Brownies & Blondies',
    emoji: '🍫',
    sections: [
      MenuSection(
        title: 'Brownies & Blondies',
        servingSize: 'Each serving weighs 100 grams',
        items: [
          MenuItem(name: 'Walnut Brownie', price: 200),
          MenuItem(name: 'Peanut Butter Brownie', price: 200),
          MenuItem(name: 'Crunchy Caramel Brownie', price: 200),
          MenuItem(name: 'Mango Oreo Blondies', price: 200),
          MenuItem(name: 'Strawberry Sandwich Blondies', price: 200),
          MenuItem(name: 'Rock And Roll Blondies', price: 200),
          MenuItem(name: 'Red Velvet Cheese Cream Blondies', price: 250),
          MenuItem(name: 'Lemon Cheese Cream Blondies', price: 250),
        ],
        note: 'Additional Toppings: Nutella Spread +₹50 | Biscoff +₹50',
      ),
    ],
  ),

  // =========================================================================
  // COOKIES & OTHERS
  // =========================================================================
  MenuCategory(
    id: 'cookies',
    title: 'Cookies & Others',
    emoji: '🍪',
    sections: [
      MenuSection(
        title: 'The Classic Cookies',
        servingSize: 'Each serving weighs 200 grams',
        items: [
          MenuItem(name: 'Naankhatai', price: 180),
          MenuItem(name: 'Choco Chips', price: 180),
          MenuItem(name: 'Jeera', price: 180),
          MenuItem(name: 'Coffee', price: 180),
          MenuItem(name: 'Choco Ragi', price: 180),
          MenuItem(name: 'Butter', price: 180),
          MenuItem(name: 'Almond', price: 200),
          MenuItem(name: 'Cashew', price: 220),
          MenuItem(name: 'Choco Vanilla Animal Shape (Kids Favourite)', price: 200),
        ],
        note:
            'Also available as Finger Stick Cookies @ ₹220 (250g) made with ghee & wheat flour — Wheat, Elaichi, Pineapple, Choco Ragi, Cashew, Pistachio, Almond',
      ),
      MenuSection(
        title: 'The Healthy Cookies',
        servingSize: 'Each serving weighs 200 grams',
        items: [
          MenuItem(name: 'Red Velvet Choco Chunk', price: 300),
          MenuItem(name: 'Honey Lime Coconut', price: 300),
          MenuItem(name: 'Peanut Butter Flaky', price: 300),
          MenuItem(name: 'Oatmeal Choco Chips', price: 300),
          MenuItem(name: 'Protein Pack Cookies', price: 300),
          MenuItem(name: 'Banana Finger Millet', price: 300),
          MenuItem(name: 'Pistachio Dual', price: 300),
          MenuItem(name: 'Keto Cookies', price: 300),
          MenuItem(name: 'Flax Chia Seed Cookies', price: 300),
          MenuItem(name: 'Oats Sesame Cookies', price: 300),
        ],
      ),
      MenuSection(
        title: 'Flavored Makhana',
        servingSize: 'Each serving weighs 60 grams',
        items: [
          MenuItem(name: 'Mint Makhana', price: 150),
          MenuItem(name: 'Peri-Peri Makhana', price: 150),
          MenuItem(name: 'Cheese Makhana', price: 150),
          MenuItem(name: 'Caramel Makhana', price: 200),
          MenuItem(name: 'Maggi Masala Makhana', price: 150),
          MenuItem(name: 'Mint Cashew Makhana', price: 150),
          MenuItem(name: 'Peri-Peri Cashew Makhana', price: 150),
        ],
      ),
    ],
  ),

  // =========================================================================
  // CHOCOLATES
  // =========================================================================
  MenuCategory(
    id: 'chocolates',
    title: 'Chocolates',
    emoji: '🍬',
    sections: [
      MenuSection(
        title: 'Assorted Chocolates',
        servingSize: 'Each serving weighs 100 grams',
        items: [
          MenuItem(
              name: 'Liquid Center Chocolate (Filled with Flavor)', price: 180),
          MenuItem(name: 'Dry Fruit Chocolate', price: 250),
          MenuItem(name: 'Dates Chocolate', price: 200),
          MenuItem(name: 'Almond Chocolate', price: 200),
          MenuItem(
              name: 'Oreo Lollipop Chocolate',
              price: 15,
              priceNote: 'per piece'),
          MenuItem(name: 'Chocolate Coated Cashew', price: 250),
          MenuItem(name: 'Chocolate Coated Almond', price: 250),
          MenuItem(name: 'Crunchy Chocolate', price: 140),
        ],
      ),
    ],
  ),
];
