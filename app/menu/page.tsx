"use client";

import { useState } from "react";
import Header from "../components/Header";
import { menu, businessInfo, MenuCategory } from "../data/menu";

// ---------------------------------------------------------------------------
// Tab navigation component
// ---------------------------------------------------------------------------
function CategoryTabs({
  categories,
  activeId,
  onSelect,
}: {
  categories: MenuCategory[];
  activeId: string;
  onSelect: (id: string) => void; // eslint-disable-line no-unused-vars
}) {
  return (
    <div className="sticky top-0 z-20 bg-[#fdf6ee] border-b border-[#e8d5b0] shadow-sm">
      <div className="max-w-5xl mx-auto px-4 overflow-x-auto">
        <div className="flex gap-1 py-3 min-w-max">
          {categories.map((cat) => (
            <button
              key={cat.id}
              onClick={() => onSelect(cat.id)}
              className={`px-4 py-2 rounded-full text-sm font-semibold transition-all duration-200 whitespace-nowrap ${
                activeId === cat.id
                  ? "bg-[#c0392b] text-white shadow-md scale-105"
                  : "bg-white text-[#7b3f2e] border border-[#e8c9a0] hover:bg-[#faebd7] hover:border-[#c0392b]"
              }`}
            >
              <span className="mr-1">{cat.emoji}</span>
              {cat.title}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Individual menu item row
// ---------------------------------------------------------------------------
function MenuItemRow({
  name,
  price,
  priceNote,
}: {
  name: string;
  price: number;
  priceNote?: string;
}) {
  return (
    <div className="flex items-start justify-between gap-4 py-3 border-b border-dashed border-[#e8d5b0] last:border-0 group hover:bg-[#fdf0e0] transition-colors duration-150 px-2 rounded-lg -mx-2">
      <span className="text-[#5c2d1e] font-medium text-sm leading-snug flex-1">
        {name}
      </span>
      <span className="text-[#c0392b] font-bold text-sm whitespace-nowrap shrink-0">
        ₹{price.toLocaleString("en-IN")}
        {priceNote && (
          <span className="text-[#a0522d] font-normal text-xs ml-1">
            /{priceNote}
          </span>
        )}
      </span>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Section block within a category
// ---------------------------------------------------------------------------
function MenuSectionBlock({
  title,
  servingSize,
  items,
  note,
}: {
  title: string;
  servingSize?: string;
  items: { name: string; price: number; priceNote?: string }[];
  note?: string;
}) {
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-[#f0ddc0] overflow-hidden mb-6">
      {/* Section header */}
      <div className="bg-[#c0392b] px-5 py-3">
        <h3 className="text-white font-bold text-base tracking-wide">{title}</h3>
        {servingSize && (
          <p className="text-[#f9c5b5] text-xs mt-0.5 flex items-center gap-1">
            <span>🥐</span> {servingSize}
          </p>
        )}
      </div>

      {/* Items */}
      <div className="px-5 py-2">
        {items.map((item, idx) => (
          <MenuItemRow
            key={idx}
            name={item.name}
            price={item.price}
            priceNote={item.priceNote}
          />
        ))}
      </div>

      {/* Footer note */}
      {note && (
        <div className="bg-[#fff8f0] border-t border-[#f0ddc0] px-5 py-3">
          <p className="text-[#8b4513] text-xs leading-relaxed">
            <span className="font-semibold">📌 Note: </span>
            {note}
          </p>
        </div>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Main Menu Page
// ---------------------------------------------------------------------------
export default function MenuPage() {
  const [activeCategory, setActiveCategory] = useState(menu[0].id);

  const currentCategory = menu.find((c) => c.id === activeCategory)!;

  return (
    <>
      <Header />
      <main className="min-h-screen bg-[#fdf6ee]">
        {/* ------------------------------------------------------------------ */}
        {/* Hero header */}
        {/* ------------------------------------------------------------------ */}
      <div
        className="relative bg-[#c0392b] text-white text-center py-12 px-4 overflow-hidden"
        style={{
          backgroundImage:
            "radial-gradient(circle at 20% 50%, #922b21 0%, transparent 60%), radial-gradient(circle at 80% 20%, #e74c3c 0%, transparent 50%)",
        }}
      >
        {/* Decorative circles */}
        <div className="absolute -top-8 -left-8 w-32 h-32 rounded-full bg-white opacity-5" />
        <div className="absolute -bottom-6 -right-6 w-24 h-24 rounded-full bg-white opacity-5" />

        <div className="relative z-10">
          <p className="text-[#f9c5b5] text-sm font-medium tracking-widest uppercase mb-1">
            By {businessInfo.baker}
          </p>
          <h1 className="text-4xl md:text-5xl font-extrabold tracking-tight mb-2">
            Our Menu
          </h1>
          <p className="text-[#fcd9ce] text-sm max-w-md mx-auto">
            Freshly baked on the same day · No preservatives · Home delivery
            within 5 km
          </p>
          <a
            href={`https://wa.me/91${businessInfo.whatsapp}`}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-2 mt-5 bg-white text-[#c0392b] font-bold px-5 py-2.5 rounded-full text-sm shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-200"
          >
            <svg
              viewBox="0 0 24 24"
              className="w-4 h-4 fill-current"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
            </svg>
            Order on WhatsApp
          </a>
        </div>
      </div>

      {/* ------------------------------------------------------------------ */}
      {/* Category tabs */}
      {/* ------------------------------------------------------------------ */}
      <CategoryTabs
        categories={menu}
        activeId={activeCategory}
        onSelect={setActiveCategory}
      />

      {/* ------------------------------------------------------------------ */}
      {/* Menu content */}
      {/* ------------------------------------------------------------------ */}
      <div className="max-w-5xl mx-auto px-4 py-8">
        {/* Category title */}
        <div className="flex items-center gap-3 mb-6">
          <span className="text-4xl">{currentCategory.emoji}</span>
          <div>
            <h2 className="text-2xl font-extrabold text-[#7b1f1f] leading-tight">
              {currentCategory.title}
            </h2>
            <p className="text-[#a0522d] text-xs">
              {currentCategory.sections.length} section
              {currentCategory.sections.length > 1 ? "s" : ""} ·{" "}
              {currentCategory.sections.reduce(
                (sum, s) => sum + s.items.length,
                0
              )}{" "}
              items
            </p>
          </div>
        </div>

        {/* Two-column layout on larger screens */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {currentCategory.sections.map((section, idx) => (
            <div
              key={idx}
              className={
                // If section has many items, span full width
                section.items.length > 8 ? "md:col-span-2" : ""
              }
            >
              <MenuSectionBlock
                title={section.title}
                servingSize={section.servingSize}
                items={section.items}
                note={section.note}
              />
            </div>
          ))}
        </div>
      </div>

      {/* ------------------------------------------------------------------ */}
      {/* Footer */}
      {/* ------------------------------------------------------------------ */}
      <footer className="bg-[#7b1f1f] text-white text-center py-8 px-4 mt-8">
        <div className="max-w-md mx-auto space-y-2">
          <p className="font-bold text-lg">{businessInfo.name}</p>
          <p className="text-[#f9c5b5] text-sm">{businessInfo.baker}</p>
          <p className="text-[#f9c5b5] text-sm">{businessInfo.address}</p>
          <a
            href={`tel:+91${businessInfo.phone}`}
            className="inline-block text-white font-bold text-base hover:text-[#f9c5b5] transition-colors"
          >
            📞 {businessInfo.phone}
          </a>
          <div className="pt-2 space-y-1">
            {businessInfo.taglines.map((t, i) => (
              <p key={i} className="text-[#f9c5b5] text-xs">
                {t}
              </p>
            ))}
          </div>
        </div>
      </footer>
      </main>
    </>
  );
}
