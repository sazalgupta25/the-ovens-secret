import { MenuCategory } from "./types";

export const specialCakesCategory: MenuCategory = {
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
