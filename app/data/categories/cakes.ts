import { MenuCategory } from "./types";

export const cakesCategory: MenuCategory = {
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
