import { MenuCategory } from "./types";

export const cookiesCategory: MenuCategory = {
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
