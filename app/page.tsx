import Header from "./components/Header";
import Footer from "./components/Footer";
import Link from "next/link";
import Image from "next/image";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Custom Cakes & Treats | The Ovens Secret - Baked with Love by Priya",
  description:
    "Discover beautiful, handcrafted custom cakes, cookies, and treats from The Ovens Secret. Home-baked with love by Priya Gupta for your special celebrations.",
  keywords: [
    "custom cakes",
    "home baker",
    "birthday cakes",
    "celebration cakes",
    "homemade cakes",
    "Priya Gupta baker",
  ],
  authors: [{ name: "Priya Gupta", url: "https://the-ovens-secret.web.app/" }],
  creator: "Priya Gupta",
  publisher: "The Ovens Secret",
  openGraph: {
    title: "The Ovens Secret - Custom Cakes Baked with Love",
    description:
      "Beautiful, handcrafted cakes and treats for all your special moments.",
    type: "website",
    locale: "en_IN",
    url: "https://the-ovens-secret.web.app/",
    siteName: "The Ovens Secret",
    images: [
      {
        url: "https://the-ovens-secret.web.app/og-image.jpg", // Replace with an actual image URL
        width: 1200,
        height: 630,
        alt: "A beautiful custom cake from The Ovens Secret",
      },
    ],
  },
  robots: {
    index: true,
    follow: true,
  },
  alternates: {
    canonical: "https://the-ovens-secret.web.app/",
  },
};

export default function Home() {
  return (
    <div className="min-h-screen bg-[#fdf6ee]">
      <Header />
      <main>
        {/* Hero Section */}
        <section className="text-center py-20 px-4 bg-gradient-to-r from-amber-50 to-orange-50">
          <h1 className="text-4xl md:text-5xl font-extrabold text-[#7b1f1f] mb-4">
            From Our Oven to Your Celebration
          </h1>
          <p className="text-lg md:text-xl text-[#a0522d] max-w-2xl mx-auto mb-8">
            Handcrafted, personalized cakes and treats baked with love by Priya Gupta. Let's make your special moments a little sweeter.
          </p>
          <Link
            href="/menu"
            className="bg-[#c0392b] text-white px-8 py-3 rounded-full hover:bg-[#a52a1a] transition font-semibold shadow-lg"
          >
            Explore Our Creations
          </Link>
        </section>

        {/* About Us Preview */}
        <section className="py-16 px-4">
          <div className="max-w-4xl mx-auto text-center">
            <h2 className="text-3xl font-bold text-[#7b1f1f] mb-4">Baked with Love by Priya</h2>
            <p className="text-[#5c2d1e] text-lg leading-relaxed mb-8">
              Hello! I'm Priya Gupta, the heart and hands behind The Ovens Secret. For me, baking has never been just about flour and sugar; it's about love, family, and the joy of creating something beautiful for a special moment.
            </p>
            <Link
              href="/about"
              className="border-2 border-[#c0392b] text-[#c0392b] px-8 py-3 rounded-full hover:bg-[#c0392b] hover:text-white transition font-semibold"
            >
              Read Our Story
            </Link>
          </div>
        </section>

        {/* Gallery Preview - Placeholder */}
        <section className="bg-white py-16 px-4">
          <div className="max-w-6xl mx-auto">
            <h2 className="text-3xl font-bold text-[#7b1f1f] text-center mb-8">A Glimpse of Our Creations</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {/* Add images of cakes here */}
              <div className="bg-gray-200 h-64 rounded-lg flex items-center justify-center">
                <Image src="/cake/cake1.png" alt="Custom Cake 1" width={200} height={200} />
              </div>
              <div className="bg-gray-200 h-64 rounded-lg flex items-center justify-center">
                <Image src="/cake/cake2.png" alt="Custom Cake 2" width={200} height={200} />
              </div>
              <div className="bg-gray-200 h-64 rounded-lg flex items-center justify-center">
                <Image src="/cake/cake3.png" alt="Custom Cake 3" width={200} height={200} />
              </div>
              <div className="bg-gray-200 h-64 rounded-lg flex items-center justify-center">
                <Image src="/cake/cake4.png" alt="Custom Cake 4" width={200} height={200} />
              </div>
              <div className="bg-gray-200 h-64 rounded-lg flex items-center justify-center">
                <Image src="/cake/cake5.png" alt="Custom Cake 5" width={200} height={200} />
              </div>
              <div className="bg-gray-200 h-64 rounded-lg flex items-center justify-center">
                <Image src="/cake/cake6.png" alt="Custom Cake 6" width={200} height={200} />
              </div>
            </div>
            <div className="text-center mt-8">
                <p className="text-[#5c2d1e] text-lg">
                    For more beautiful cakes, check out our Instagram!
                </p>
            </div>
          </div>
        </section>

        {/* How to Order */}
        <section className="py-16 px-4">
            <div className="max-w-4xl mx-auto text-center">
                <h2 className="text-3xl font-bold text-[#7b1f1f] mb-8">How to Order Your Custom Cake</h2>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                    <div>
                        <h3 className="text-2xl font-bold text-[#c0392b] mb-2">1. Get in Touch</h3>
                        <p className="text-[#5c2d1e]">Send us a message on WhatsApp or give us a call to discuss your ideas.</p>
                    </div>
                    <div>
                        <h3 className="text-2xl font-bold text-[#c0392b] mb-2">2. Design Your Cake</h3>
                        <p className="text-[#5c2d1e]">We'll work with you to design the perfect cake for your occasion.</p>
                    </div>
                    <div>
                        <h3 className="text-2xl font-bold text-[#c0392b] mb-2">3. Celebrate!</h3>
                        <p className="text-[#5c2d1e]">Your custom cake will be ready for pickup or delivery on your special day.</p>
                    </div>
                </div>
            </div>
        </section>

        {/* Testimonials */}
        <section className="bg-gradient-to-r from-amber-50 to-orange-50 py-16 px-4">
          <div className="max-w-4xl mx-auto text-center">
            <h2 className="text-3xl font-bold text-[#7b1f1f] mb-8">What Our Customers Say</h2>
            <div className="space-y-8">
              <div className="p-6 bg-white rounded-lg shadow-md">
                <p className="text-[#5c2d1e] italic">"The cake was not only beautiful but absolutely delicious! Priya is a true artist."</p>
                <p className="text-right text-amber-800 font-semibold mt-4">- A Happy Customer</p>
              </div>
              <div className="p-6 bg-white rounded-lg shadow-md">
                <p className="text-[#5c2d1e] italic">"I ordered a custom cake for my daughter's birthday and it was the highlight of the party. Thank you, Priya!"</p>
                <p className="text-right text-amber-800 font-semibold mt-4">- Another Satisfied Client</p>
              </div>
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="bg-[#c0392b] text-white p-12 text-center">
          <h2 className="text-3xl font-bold mb-4">Have a Special Occasion Coming Up?</h2>
          <p className="text-lg mb-8 opacity-90">
            Let's create a cake that tells your story. For custom orders, questions, or just to say hello, get in touch with Priya.
          </p>
          <a
            href="https://wa.me/919740264800"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-block bg-white text-[#c0392b] px-8 py-3 rounded-full font-semibold hover:bg-gray-100 transition"
          >
            Order Your Custom Cake
          </a>
        </section>
      </main>
      <Footer />
    </div>
  );
}
