import { MenuCategory } from "./types";

export const browniesCategory: MenuCategory = {
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
