export default function Header() {
  return (
    <header className="bg-amber-900 text-white shadow-lg sticky top-0 z-50">
      <nav className="max-w-6xl mx-auto px-4 py-4 flex justify-between items-center">
        <div className="flex items-center gap-8">
          <a href="/" className="text-3xl font-bold hover:text-amber-100 transition">
            🔥 The Ovens Secret
          </a>
          <ul className="hidden md:flex gap-6 font-semibold">
            <li>
              <a
                href="/"
                className="hover:text-amber-200 transition duration-200"
              >
                Home
              </a>
            </li>
            <li>
              <a
                href="/menu"
                className="hover:text-amber-200 transition duration-200"
              >
                Menu
              </a>
            </li>
            <li>
              <a
                href="/recipes"
                className="hover:text-amber-200 transition duration-200"
              >
                Recipes
              </a>
            </li>
            <li>
              <a
                href="/about"
                className="hover:text-amber-200 transition duration-200"
              >
                About
              </a>
            </li>
            <li>
              <a
                href="/contact"
                className="hover:text-amber-200 transition duration-200"
              >
                Contact
              </a>
            </li>
          </ul>
        </div>

        {/* Mobile Menu Indicator */}
        <div className="md:hidden">
          <button
            className="text-2xl hover:text-amber-200 transition"
            aria-label="Toggle menu"
          >
            ☰
          </button>
        </div>
      </nav>
    </header>
  );
}
