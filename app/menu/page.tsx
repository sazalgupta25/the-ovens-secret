import type { Metadata } from 'next';
import Header from '../components/Header';
import Footer from '../components/Footer';

export const metadata: Metadata = {
  title: 'Menu | Artisan Breads | The Ovens Secret',
  description:
    'Browse our artisan bread menu: sourdough, focaccia, specialty breads, and custom orders. Premium ingredients, traditional methods.',
  keywords: [
    'artisan bread menu',
    'sourdough bread',
    'focaccia bread',
    'premium bread',
    'specialty breads',
    'custom bread orders',
  ],
  openGraph: {
    title: 'Our Artisan Bread Menu | The Ovens Secret',
    description: 'Premium artisan breads crafted with tradition and care',
    type: 'website',
    locale: 'en_US',
  },
  robots: {
    index: true,
    follow: true,
  },
};

// Menu data from PDF
const menuCategories = [
  {
    id: 'sourdough',
    name: 'Sourdough Collection',
    description: 'Our signature sourdough breads with authentic flavors',
    items: [
      {
        name: 'Classic Sourdough',
        description: 'Traditional French-style sourdough with tangy flavor and crispy crust',
        price: '$6.50',
        details: '500g | 48-hour fermentation | Naturally leavened',
      },
      {
        name: 'Sourdough with Seeds',
        description: 'Premium sourdough topped with sunflower, pumpkin, and sesame seeds',
        price: '$7.50',
        details: '550g | Mixed organic seeds | High fiber content',
      },
      {
        name: 'Charcoal Sourdough',
        description: 'Gourmet sourdough infused with activated charcoal for a unique appearance and mild earthy notes',
        price: '$8.00',
        details: '500g | Food-grade charcoal | Premium ingredient',
      },
    ],
  },
  {
    id: 'focaccia',
    name: 'Focaccia Selection',
    description: 'Italian-inspired focaccia breads with premium toppings',
    items: [
      {
        name: 'Rosemary & Sea Salt',
        description: 'Classic focaccia with fresh rosemary and Maldon sea salt',
        price: '$5.50',
        details: '400g | Italian olive oil | Fresh herbs',
      },
      {
        name: 'Garlic & Herb',
        description: 'Infused with roasted garlic and mixed Italian herbs',
        price: '$6.00',
        details: '400g | Roasted garlic | Oregano & basil',
      },
      {
        name: 'Olive & Tomato',
        description: 'Mediterranean focaccia with Kalamata olives and sun-dried tomatoes',
        price: '$6.50',
        details: '420g | Kalamata olives | Sun-dried tomatoes',
      },
      {
        name: 'Caramelized Onion & Brie',
        description: 'Indulgent focaccia with sweet caramelized onions and creamy Brie cheese',
        price: '$7.50',
        details: '450g | Artisan Brie | 4-hour caramelization',
      },
    ],
  },
  {
    id: 'specialty',
    name: 'Specialty Breads',
    description: 'Unique artisan breads crafted with premium ingredients',
    items: [
      {
        name: 'Whole Wheat',
        description: 'Nutty whole wheat bread with sprouted grains and honey notes',
        price: '$5.00',
        details: '550g | Sprouted grains | High protein',
      },
      {
        name: 'Ciabatta',
        description: 'Authentic Italian ciabatta with airy crumb and crispy exterior',
        price: '$5.50',
        details: '480g | 20-hour fermentation | Italian flour',
      },
      {
        name: 'Rye & Caraway',
        description: 'Traditional European-style rye bread with caraway seeds',
        price: '$5.50',
        details: '550g | Organic rye | Caraway seeds',
      },
      {
        name: 'Multigrain Harvest',
        description: 'Hearty blend of oats, millet, flax, and sunflower seeds',
        price: '$6.50',
        details: '600g | 7 grains | Vegan-friendly',
      },
    ],
  },
  {
    id: 'custom',
    name: 'Custom Orders',
    description: 'Create your perfect bread with personalized options',
    items: [
      {
        name: 'Build Your Own Bread',
        description: 'Choose your base, mix-ins, and toppings for a truly unique loaf',
        price: 'From $8.00',
        details: 'Minimum 48-hour notice | Dietary accommodations available',
      },
      {
        name: 'Bulk Orders',
        description: 'Perfect for events, restaurants, or catering. We offer wholesale pricing.',
        price: 'Custom quote',
        details: '5+ loaves | Corporate discounts | Delivery available',
      },
      {
        name: 'Gluten-Free Line',
        description: 'Premium gluten-free breads made with dedicated equipment',
        price: '$8.50 each',
        details: 'Certified gluten-free | Nut-free facility',
      },
    ],
  },
];

export default function MenuPage() {
  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main className="max-w-6xl mx-auto px-4 py-12">
        {/* Page Header */}
        <section className="text-center mb-12">
          <h1 className="text-5xl font-bold text-amber-900 mb-4">Our Menu</h1>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">
            Discover our artisan bread collection, carefully crafted with premium ingredients and traditional methods.
          </p>
        </section>

        {/* Display all categories */}
        {menuCategories.map((category) => (
          <section key={category.id} className="mb-16">
            <div className="mb-8">
              <h2 className="text-3xl font-bold text-amber-900 mb-2">
                {category.name}
              </h2>
              <p className="text-gray-600 text-lg">
                {category.description}
              </p>
            </div>

            {/* Menu Items Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
              {category.items.map((item, index) => (
                <article
                  key={index}
                  className="p-6 bg-gradient-to-br from-amber-50 to-orange-50 rounded-lg border-2 border-amber-200 hover:border-amber-400 transition"
                >
                  <div className="flex justify-between items-start mb-3">
                    <h3 className="text-2xl font-bold text-amber-900">
                      {item.name}
                    </h3>
                    <span className="text-xl font-bold text-amber-800 whitespace-nowrap ml-4">
                      {item.price}
                    </span>
                  </div>
                  <p className="text-gray-700 mb-4 text-base leading-relaxed">
                    {item.description}
                  </p>
                  <div className="pt-4 border-t border-amber-200">
                    <p className="text-sm text-gray-600">
                      <span className="font-semibold">Details:</span> {item.details}
                    </p>
                  </div>
                </article>
              ))}
            </div>
          </section>
        ))}

        {/* Call to Action */}
        <section className="bg-gradient-to-r from-amber-900 to-amber-800 text-white p-12 rounded-lg text-center mb-12">
          <h2 className="text-3xl font-bold mb-4">Ready to Order?</h2>
          <p className="text-lg mb-6 opacity-90">
            Contact us today for local pickups, deliveries, or custom orders.
          </p>
          <div className="flex gap-4 justify-center flex-wrap">
            <a
              href="/contact"
              className="bg-white text-amber-900 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition"
            >
              Place Order
            </a>
            <a
              href="tel:+1234567890"
              className="border-2 border-white text-white px-8 py-3 rounded-lg font-semibold hover:bg-white hover:text-amber-900 transition"
            >
              Call Us
            </a>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
