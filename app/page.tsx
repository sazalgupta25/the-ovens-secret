import type { Metadata } from "next";
import Header from "./components/Header";
import Footer from "./components/Footer";
import { MenuPreviewCard } from "./components/MenuPreviewCard";

export const metadata: Metadata = {
  title: "Artisan Bakery | The Ovens Secret - Premium Sourdough & Breads",
  description:
    "Discover premium artisan breads at The Ovens Secret. Handcrafted sourdough, focaccia, and specialty breads using traditional fermentation. Learn baking techniques from expert bakers.",
  keywords: [
    "artisan bakery",
    "sourdough bread",
    "premium bread",
    "artisan breads",
    "bread recipes",
    "baking techniques",
    "fermented bread",
    "focaccia",
  ],
  authors: [{ name: "The Ovens Secret Team", url: "https://theovenssecret.com" }],
  creator: "The Ovens Secret",
  publisher: "The Ovens Secret",
  openGraph: {
    title: "The Ovens Secret - Premium Artisan Breads",
    description:
      "Discover the art of artisan baking with handcrafted breads and expert techniques.",
    type: "website",
    locale: "en_US",
    url: "https://theovenssecret.com",
    siteName: "The Ovens Secret",
    images: [
      {
        url: "https://theovenssecret.com/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "Premium Artisan Breads from The Ovens Secret",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "The Ovens Secret - Premium Artisan Breads",
    description: "Discover handcrafted breads and expert baking techniques",
    images: ["https://theovenssecret.com/og-image.jpg"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-image-preview": "large",
      "max-snippet": -1,
      "max-video-preview": -1,
    },
  },
  alternates: {
    canonical: "https://theovenssecret.com",
  },
};

export default function Home() {
  const features = [
    {
      title: "🍞 Artisan Recipes",
      description:
        "Discover time-honored bread recipes with modern techniques, from classic sourdough to Italian focaccia and specialty grains.",
    },
    {
      title: "📚 Knowledge Base",
      description:
        "Learn the science behind perfect baking, fermentation processes, and how to develop your bread-making expertise.",
    },
    {
      title: "👨‍🍳 Expert Tips",
      description:
        "Get insights from professional bakers and seasoned enthusiasts in the artisan baking community.",
    },
    {
      title: "🔥 Oven Mastery",
      description:
        "Master temperature control, baking times, and techniques for achieving professional-quality results every time.",
    },
  ];

  return (
    <div className="min-h-screen bg-white">
      <Header />

      {/* Schema.org JSON-LD structured data */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "LocalBusiness",
            name: "The Ovens Secret",
            description:
              "Premium artisan bakery crafting handmade sourdough and specialty breads with traditional fermentation methods",
            url: "https://theovenssecret.com",
            telephone: "+1-234-567-8900",
            address: {
              "@type": "PostalAddress",
              addressCountry: "US",
            },
            priceRange: "$$",
            image: "https://theovenssecret.com/og-image.jpg",
            sameAs: [
              "https://www.facebook.com/theovenssecret",
              "https://www.instagram.com/theovenssecret",
            ],
          }),
        }}
      />

      <main className="max-w-6xl mx-auto px-4 py-12">
        {/* Hero Section */}
        <section className="text-center py-12 mb-16">
          <h1 className="text-5xl font-bold text-amber-900 mb-4">
            Welcome to The Ovens Secret
          </h1>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto mb-8">
            Unlock the mysteries of artisan baking and discover the techniques
            that turn simple ingredients into extraordinary bread.
          </p>
          <div className="flex gap-4 justify-center flex-wrap">
            <a
              href="/menu"
              className="bg-amber-900 text-white px-8 py-3 rounded-lg hover:bg-amber-800 transition font-semibold"
            >
              Browse Our Menu
            </a>
            <a
              href="/recipes"
              className="bg-orange-700 text-white px-8 py-3 rounded-lg hover:bg-orange-600 transition font-semibold"
            >
              Explore Recipes
            </a>
            <a
              href="/about"
              className="border-2 border-amber-900 text-amber-900 px-8 py-3 rounded-lg hover:bg-amber-50 transition font-semibold"
            >
              Learn More
            </a>
          </div>
        </section>

        {/* Features Grid */}
        <section
          className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16"
          aria-label="Our Services"
        >
          {features.map((feature, index) => (
            <article
              key={index}
              className="p-6 bg-amber-50 rounded-lg border border-amber-200 hover:shadow-lg transition"
            >
              <h3 className="text-2xl font-bold text-amber-900 mb-2">
                {feature.title}
              </h3>
              <p className="text-gray-700 leading-relaxed">
                {feature.description}
              </p>
            </article>
          ))}
        </section>

        <MenuPreviewCard />

        {/* About Preview */}
        <section className="bg-gradient-to-r from-amber-50 to-orange-50 p-12 rounded-lg mb-12">
          <h2 className="text-3xl font-bold text-amber-900 mb-4">
            Why Choose The Ovens Secret?
          </h2>
          <p className="text-gray-700 text-lg mb-4 leading-relaxed">
            With over a decade of experience in artisan baking, we've curated
            the finest collection of recipes, techniques, and tips that will
            elevate your baking to professional standards. Our commitment to
            quality, traditional fermentation methods, and premium ingredients
            sets us apart.
          </p>
          <p className="text-gray-700 text-lg leading-relaxed">
            Whether you're a beginner just starting your bread-baking journey
            or an advanced baker seeking to refine your craft, our comprehensive
            guides and expert insights will help you master the art of creating
            perfect bread every time.
          </p>
        </section>

        {/* CTA Section */}
        <section className="bg-amber-900 text-white p-12 rounded-lg text-center">
          <h2 className="text-3xl font-bold mb-4">Ready to Transform Your Baking?</h2>
          <p className="text-lg mb-8 opacity-90">
            Start exploring our recipes, order premium artisan breads, or join our community of passionate bakers.
          </p>
          <a
            href="/contact"
            className="inline-block bg-white text-amber-900 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition"
          >
            Get Started Today
          </a>
        </section>
      </main>
      <Footer />
    </div>
  );
}
