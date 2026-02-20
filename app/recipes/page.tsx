import type { Metadata } from "next";
import Header from "../components/Header";
import Footer from "../components/Footer";

export const metadata: Metadata = {
  title: "Bread Recipes | Sourdough & Artisan Baking | The Ovens Secret",
  description:
    "Discover our collection of artisan baking recipes: sourdough, focaccia, ciabatta, and whole wheat. Step-by-step guides with professional techniques.",
  keywords: [
    "bread recipes",
    "sourdough recipe",
    "focaccia recipe",
    "artisan baking",
    "homemade bread",
    "bread making",
    "Italian bread",
    "whole wheat bread recipe",
  ],
  openGraph: {
    title: "Bread Recipes | The Ovens Secret",
    description: "Discover artisan baking recipes and techniques",
    type: "website",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function RecipesPage() {
  const recipes = [
    {
      id: 1,
      title: "Classic Sourdough",
      description:
        "Traditional French-style sourdough with tangy flavor and crispy crust. Learn the perfect fermentation times and oven techniques.",
      difficulty: "Intermediate",
      time: "24 hours",
      servings: "1 loaf",
      tags: ["sourdough", "advanced", "popular"],
    },
    {
      id: 2,
      title: "Focaccia Genovese",
      description:
        "Soft and aromatic Italian focaccia topped with olive oil and fresh rosemary. Perfect for beginners learning bread basics.",
      difficulty: "Beginner",
      time: "4 hours",
      servings: "1 flatbread",
      tags: ["focaccia", "italian", "starter"],
    },
    {
      id: 3,
      title: "Ciabatta",
      description:
        "Authentic Italian ciabatta with a light, airy open crumb and crispy exterior. Advanced bakers will appreciate the high-hydration dough.",
      difficulty: "Advanced",
      time: "18 hours",
      servings: "2 loaves",
      tags: ["ciabatta", "italian", "advanced"],
    },
    {
      id: 4,
      title: "Whole Wheat Bread",
      description:
        "Nutritious and hearty whole wheat loaf made with sprouted grains. Great for beginners and packed with fiber.",
      difficulty: "Beginner",
      time: "2 hours",
      servings: "1 loaf",
      tags: ["whole wheat", "healthy", "quick"],
    },
    {
      id: 5,
      title: "Rye & Caraway",
      description:
        "Traditional European-style rye bread with distinctive caraway seeds. Rich, dense crumb perfect for sandwiches.",
      difficulty: "Intermediate",
      time: "20 hours",
      servings: "1 loaf",
      tags: ["rye", "european", "savory"],
    },
    {
      id: 6,
      title: "Multigrain Harvest",
      description:
        "Hearty blend of oats, millet, flax, and sunflower seeds. A complete meal with high nutritional value.",
      difficulty: "Intermediate",
      time: "3 hours",
      servings: "2 loaves",
      tags: ["multigrain", "seeds", "healthy"],
    },
  ];

  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main className="max-w-6xl mx-auto px-4 py-12" id="main-content">
        {/* Page Header */}
        <section className="mb-12">
          <h1 className="text-5xl font-bold text-amber-900 mb-4">
            Artisan Bread Recipes
          </h1>
          <p className="text-xl text-gray-600 max-w-3xl">
            Master the art of bread making with our comprehensive collection of
            recipes. From beginner-friendly focaccia to advanced sourdough
            techniques, find step-by-step guides for creating bakery-quality
            bread at home.
          </p>
        </section>

        {/* Recipes Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
          {recipes.map((recipe) => (
            <article
              key={recipe.id}
              className="p-6 border-2 border-amber-200 rounded-lg hover:shadow-lg hover:border-amber-400 transition bg-gradient-to-br from-white to-amber-50"
            >
              <div className="mb-4">
                <h2 className="text-2xl font-bold text-amber-900 mb-2">
                  {recipe.title}
                </h2>
                <p className="text-gray-700 text-sm leading-relaxed">
                  {recipe.description}
                </p>
              </div>

              {/* Recipe Stats */}
              <div className="grid grid-cols-3 gap-3 mb-4 py-4 border-y border-amber-200">
                <div className="text-center">
                  <p className="text-xs text-gray-500 uppercase tracking-wide">
                    Time
                  </p>
                  <p className="font-semibold text-amber-900">⏱️ {recipe.time}</p>
                </div>
                <div className="text-center">
                  <p className="text-xs text-gray-500 uppercase tracking-wide">
                    Level
                  </p>
                  <p className="font-semibold text-amber-900">
                    {recipe.difficulty === "Beginner" && "🌱"}
                    {recipe.difficulty === "Intermediate" && "🌾"}
                    {recipe.difficulty === "Advanced" && "🔥"}
                  </p>
                </div>
                <div className="text-center">
                  <p className="text-xs text-gray-500 uppercase tracking-wide">
                    Yield
                  </p>
                  <p className="font-semibold text-amber-900">{recipe.servings}</p>
                </div>
              </div>

              {/* Tags */}
              <div className="mb-4 flex flex-wrap gap-2">
                {recipe.tags.map((tag) => (
                  <span
                    key={tag}
                    className="text-xs bg-amber-100 text-amber-800 px-3 py-1 rounded-full"
                  >
                    {tag}
                  </span>
                ))}
              </div>

              {/* CTA Button */}
              <button className="mt-4 bg-amber-900 text-white px-4 py-2 rounded-lg hover:bg-amber-800 transition w-full font-semibold">
                View Full Recipe
              </button>
            </article>
          ))}
        </div>

        {/* CTA Section */}
        <section className="bg-gradient-to-r from-amber-900 to-orange-800 text-white p-12 rounded-lg text-center">
          <h2 className="text-3xl font-bold mb-4">Want to Share Your Recipe?</h2>
          <p className="text-lg mb-8 opacity-90">
            Have a signature bread recipe? We'd love to feature it in our
            community collection.
          </p>
          <a
            href="/contact"
            className="inline-block bg-white text-amber-900 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition"
          >
            Submit Your Recipe
          </a>
        </section>
      </main>
      <Footer />
    </div>
  );
}
