import { MenuCategory } from "./types";

export const chocolatesCategory: MenuCategory = {
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
