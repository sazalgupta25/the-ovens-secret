"use client";

import Header from "../components/Header";
import { businessInfo } from "../data/menu";

export default function AboutPage() {
  return (
    <>
      <Header />
      <main className="min-h-screen bg-[#fdf6ee] py-12 px-4">
        <div className="max-w-3xl mx-auto bg-white p-8 rounded-2xl shadow-lg border border-[#f0ddc0]">
          <h1 className="text-3xl md:text-4xl font-extrabold text-[#7b1f1f] text-center mb-6">
            Welcome to The Oven's Secret
          </h1>
          <div className="text-center mb-8">
            <p className="text-[#a0522d] text-lg">
              Baked with Love by {businessInfo.baker}
            </p>
          </div>
          <div className="prose prose-lg max-w-none text-[#5c2d1e] leading-relaxed">
            <p>
              Hello! I'm Priya Gupta, the heart and hands behind The Ovens
              Secret. For me, baking has never been just about flour and sugar;
              it's about love, family, and the joy of creating something
              beautiful for a special moment.
            </p>
            <p>
              It all started in my home kitchen, with a passion for creating
              delicious treats for my own family's celebrations. I discovered
              that a cake is more than just a dessert—it's a centerpiece for
              our happiest memories. It’s the smile on a child's face, the
              shared slice at a family gathering, the sweet beginning to a new
              chapter.
            </p>
            <p>
              What started as a hobby has blossomed into a passion I’m
              thrilled to share with you. "The Ovens Secret" isn't a factory;
              it's my home, my kitchen, and my commitment to quality. I use the
              same wholesome ingredients and time-tested recipes that my own
              family loves.
            </p>
            <p>
              As an FSSAI-registered home baker, I take pride in every detail,
              from our first conversation about your vision to the final,
              delicate touches on your cake. Thank you for letting me be a
              small part of your big moments. I can't wait to bake for you!
            </p>
            <p className="text-right font-semibold">
              With love,
              <br />
              Priya Gupta
            </p>
          </div>
        </div>
      </main>
    </>
  );
}
