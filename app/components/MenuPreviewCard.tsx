"use client";

import Link from "next/link";
import { menu, businessInfo } from "../data/menu";

// ---------------------------------------------------------------------------
// MenuPreviewCard — shows on homepage, links to full menu page
// ---------------------------------------------------------------------------
export function MenuPreviewCard() {
  // Show price range per category
  const getPriceRange = (categoryId: string) => {
    const cat = menu.find((c) => c.id === categoryId);
    if (!cat) return "";
    const prices = cat.sections.flatMap((s) => s.items.map((i) => i.price));
    const min = Math.min(...prices);
    const max = Math.max(...prices);
    return min === max ? `₹${min}` : `₹${min} – ₹${max}`;
  };

  return (
    <section className="py-16 bg-stone-100">
      <div className="max-w-5xl mx-auto px-4">
        {/* Section heading */}
        <div className="text-center mb-10">
          <h2 className="text-3xl md:text-4xl font-extrabold text-stone-900 mb-2">
            Our Menu
          </h2>
          <p className="text-stone-700 text-sm max-w-xs mx-auto">
            Freshly baked, no preservatives · Same day delivery within 5 km
          </p>
        </div>

        {/* Category cards */}
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 mb-10">
          {menu.map((cat) => (
            <Link
              key={cat.id}
              href={`/menu#${cat.id}`}
              className="group bg-white rounded-2xl border border-stone-300 shadow-sm hover:shadow-md hover:border-stone-800 transition-all duration-200 p-4 text-center"
            >
              <div className="text-4xl mb-2 group-hover:scale-110 transition-transform duration-200">
                {cat.emoji}
              </div>
              <p className="font-bold text-stone-900 text-sm leading-tight mb-1">
                {cat.title}
              </p>
              <p className="text-stone-800 text-xs font-semibold">
                {getPriceRange(cat.id)}
              </p>
            </Link>
          ))}
        </div>

        {/* CTA */}
        <div className="text-center space-y-3">
          <Link
            href="/menu"
            className="inline-block bg-stone-800 text-stone-100 font-bold px-8 py-3 rounded-full shadow-md hover:shadow-lg hover:bg-stone-900 transition-all duration-200"
          >
            View Full Menu
          </Link>
          <div>
            <a
              href={`https://wa.me/91${businessInfo.whatsapp}?text=Hi! I'd like to place an order from The Ovens' Secret.`}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 text-[#25d366] font-semibold text-sm hover:underline"
            >
              <svg
                viewBox="0 0 24 24"
                className="w-4 h-4 fill-current"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
              </svg>
              Order via WhatsApp · {businessInfo.phone}
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
