import Header from "../components/Header";
import Footer from "../components/Footer";

export const metadata = {
  title: "Recipes | The Ovens Secret",
  description: "Browse our collection of artisan baking recipes",
};

export default function RecipesPage() {
  const recipes = [
    {
      id: 1,
      title: "Classic Sourdough",
      description: "Traditional sourdough with crispy crust and open crumb",
      difficulty: "Intermediate",
      time: "24 hours",
    },
    {
      id: 2,
      title: "Focaccia Genovese",
      description: "Soft, aromatic focaccia with olive oil and herbs",
      difficulty: "Beginner",
      time: "4 hours",
    },
    {
      id: 3,
      title: "Ciabatta",
      description: "Crispy Italian bread with a light, airy crumb",
      difficulty: "Advanced",
      time: "18 hours",
    },
    {
      id: 4,
      title: "Whole Wheat Bread",
      description: "Nutritious and hearty whole wheat loaf",
      difficulty: "Beginner",
      time: "2 hours",
    },
  ];

  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main className="max-w-6xl mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold text-amber-900 mb-8">Recipes</h1>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
          {recipes.map((recipe) => (
            <div
              key={recipe.id}
              className="p-6 border border-amber-200 rounded-lg hover:shadow-lg transition"
            >
              <h3 className="text-2xl font-bold text-amber-900 mb-2">
                {recipe.title}
              </h3>
              <p className="text-gray-600 mb-4">{recipe.description}</p>
              <div className="flex justify-between text-sm text-gray-500">
                <span>⏱️ {recipe.time}</span>
                <span>📊 {recipe.difficulty}</span>
              </div>
              <button className="mt-4 bg-amber-900 text-white px-4 py-2 rounded hover:bg-amber-800 transition w-full">
                View Recipe
              </button>
            </div>
          ))}
        </div>
      </main>
      <Footer />
    </div>
  );
}
