import Header from "../components/Header";
import Footer from "../components/Footer";

export const metadata = {
  title: "About Us | The Ovens Secret",
  description: "Learn about The Ovens Secret and our mission to promote artisan baking",
};

export default function AboutPage() {
  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main className="max-w-6xl mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold text-amber-900 mb-8">About Us</h1>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-12 mb-12">
          <div>
            <h2 className="text-2xl font-bold text-amber-900 mb-4">
              Our Mission
            </h2>
            <p className="text-gray-700 mb-4">
              At The Ovens Secret, we believe that baking is both an art and a
              science. Our mission is to share the knowledge and techniques that
              have been perfected over decades of professional baking.
            </p>
            <p className="text-gray-700">
              We&rsquo;re dedicated to helping home bakers and professionals alike
              master the craft of artisan baking, creating exceptional cakes and bread
              that delights the senses and nourishes the body.
            </p>
          </div>

          <div className="bg-amber-50 p-6 rounded-lg border border-amber-200">
            <h2 className="text-2xl font-bold text-amber-900 mb-4">
              Why We Started
            </h2>
            <p className="text-gray-700">
              Inspired by the enduring tradition of artisan baking and the joy
              of creating something with your own hands, we founded The Ovens
              Secret to preserve and promote these time-honored techniques in
              the modern age.
            </p>
          </div>
        </div>

        <section className="mb-12">
          <h2 className="text-2xl font-bold text-amber-900 mb-6">
            What We Offer
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="p-6 bg-gray-50 rounded-lg">
              <h3 className="text-xl font-bold text-amber-900 mb-2">
                📖 Recipes
              </h3>
              <p className="text-gray-600">
                Curated collection of proven recipes from around the world
              </p>
            </div>
            <div className="p-6 bg-gray-50 rounded-lg">
              <h3 className="text-xl font-bold text-amber-900 mb-2">
                🎓 Tutorials
              </h3>
              <p className="text-gray-600">
                Step-by-step guides and video tutorials for all skill levels
              </p>
            </div>
            <div className="p-6 bg-gray-50 rounded-lg">
              <h3 className="text-xl font-bold text-amber-900 mb-2">
                💡 Tips & Tricks
              </h3>
              <p className="text-gray-600">
                Expert insights and troubleshooting advice from experienced
                bakers
              </p>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
