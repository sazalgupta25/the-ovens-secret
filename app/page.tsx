import Header from "./components/Header";
import Footer from "./components/Footer";

export default function Home() {
  const features = [
    {
      title: "🍞 Artisan Recipes",
      description: "Discover time-honored bread recipes with modern techniques",
    },
    {
      title: "📚 Knowledge Base",
      description: "Learn the science behind perfect baking and fermentation",
    },
    {
      title: "👨‍🍳 Expert Tips",
      description: "Get insights from professional bakers and enthusiasts",
    },
    {
      title: "🔥 Oven Mastery",
      description: "Master the perfect temperature and timing for every recipe",
    },
  ];

  return (
    <div className="min-h-screen bg-white">
      <Header />
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
          <div className="flex gap-4 justify-center">
            <a
              href="/recipes"
              className="bg-amber-900 text-white px-8 py-3 rounded-lg hover:bg-amber-800 transition"
            >
              Explore Recipes
            </a>
            <a
              href="/about"
              className="border-2 border-amber-900 text-amber-900 px-8 py-3 rounded-lg hover:bg-amber-50 transition"
            >
              Learn More
            </a>
          </div>
        </section>

        {/* Features Grid */}
        <section className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16">
          {features.map((feature, index) => (
            <div
              key={index}
              className="p-6 bg-amber-50 rounded-lg border border-amber-200"
            >
              <h3 className="text-2xl font-bold text-amber-900 mb-2">
                {feature.title}
              </h3>
              <p className="text-gray-700">{feature.description}</p>
            </div>
          ))}
        </section>

        {/* About Preview */}
        <section className="bg-gradient-to-r from-amber-50 to-orange-50 p-12 rounded-lg mb-12">
          <h2 className="text-3xl font-bold text-amber-900 mb-4">
            Why Choose Us?
          </h2>
          <p className="text-gray-700 text-lg mb-4">
            With over a decade of experience in artisan baking, we've curated
            the finest collection of recipes, techniques, and tips that will
            elevate your baking to professional standards.
          </p>
          <p className="text-gray-700 text-lg">
            Whether you're a beginner or an advanced baker, our comprehensive
            guides and expert insights will help you master the art of creating
            perfect bread every time.
          </p>
        </section>
      </main>
      <Footer />
    </div>
  );
}
