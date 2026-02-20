export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-gray-900 text-gray-200 mt-12">
      <div className="max-w-6xl mx-auto px-4 py-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
          <div>
            <h3 className="text-lg font-bold mb-4 text-amber-400">The Ovens Secret</h3>
            <p className="text-sm">
              Exploring the art and science of artisan baking through time-honored techniques and innovative recipes.
            </p>
          </div>
          <div>
            <h4 className="text-lg font-bold mb-4 text-amber-400">Quick Links</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <a href="/" className="hover:text-amber-300">
                  Home
                </a>
              </li>
              <li>
                <a href="/recipes" className="hover:text-amber-300">
                  Recipes
                </a>
              </li>
              <li>
                <a href="/about" className="hover:text-amber-300">
                  About Us
                </a>
              </li>
            </ul>
          </div>
          <div>
            <h4 className="text-lg font-bold mb-4 text-amber-400">Contact</h4>
            <p className="text-sm">Email: info@theovens-secret.com</p>
            <p className="text-sm">Follow us on social media</p>
          </div>
        </div>
        <hr className="border-gray-700 mb-4" />
        <div className="text-center text-sm text-gray-400">
          <p>&copy; {currentYear} The Ovens Secret. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
}
