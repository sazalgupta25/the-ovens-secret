# Menu Update — Integration Guide

## What Was Added

### New Files

| File | Purpose |
|------|---------|
| `app/data/menu.ts` | **Single source of truth** for all menu data. All categories, sections, items and prices extracted from the official PDF. Update prices here — UI updates automatically. |
| `app/menu/page.tsx` | Full `/menu` page with tabbed category navigation, styled sections, per-item pricing, and WhatsApp order CTA. |
| `app/menu/layout.tsx` | SEO metadata for the `/menu` route (title, description, OG tags). |
| `app/components/MenuPreviewCard.tsx` | Reusable component to embed a menu preview + CTA on the homepage. |

---

## How to Integrate on Homepage

Open `app/page.tsx` and add the `MenuPreviewCard` wherever you want the menu preview to appear:

```tsx
// app/page.tsx
import { MenuPreviewCard } from "./components/MenuPreviewCard";

export default function HomePage() {
  return (
    <main>
      {/* ...existing homepage content... */}

      {/* Add this where you want the menu section */}
      <MenuPreviewCard />

      {/* ...rest of homepage... */}
    </main>
  );
}
```

---

## How to Update Prices

All prices live in **`app/data/menu.ts`** only. Example:

```ts
// To change Vanilla Cake from ₹350 to ₹380:
{ name: "Vanilla Cake", price: 380 },
```

No changes needed to any page or component file.

---

## How to Add a New Item

In `app/data/menu.ts`, find the right section and add to its `items` array:

```ts
// Example: add a new cake to Classic Flavors
{ name: "Mango Mousse Cake", price: 450 },
```

---

## How to Add a New Category

```ts
// In app/data/menu.ts:
const newCategory: MenuCategory = {
  id: "savories",           // used in URL hash & tab ID
  title: "Savories",
  emoji: "🥐",
  sections: [
    {
      title: "Baked Savories",
      servingSize: "Per piece",
      items: [
        { name: "Cheese Croissant", price: 120 },
      ],
    },
  ],
};

// Then add to the export array:
export const menu: MenuCategory[] = [
  cakesCategory,
  specialCakesCategory,
  browniesCategory,
  cookiesCategory,
  chocolatesCategory,
  newCategory,  // ← add here
];
```

---

## Route

The menu is available at: `https://yourdomain.com/menu`

---

## Menu Data Summary (from PDF)

| Category | Sections | Items | Price Range |
|----------|----------|-------|-------------|
| Cakes | 4 | 39 | ₹350 – ₹1050 |
| Special Cakes | 2 | 13 | ₹500 – ₹550 |
| Brownies & Blondies | 1 | 8 | ₹200 – ₹250 |
| Cookies & Others | 3 | 26 | ₹150 – ₹300 |
| Chocolates | 1 | 8 | ₹15/pc – ₹250 |
