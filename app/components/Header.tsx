export default function Header() {
  return (
    <header className="bg-amber-900 text-white shadow-lg">
      <nav className="max-w-6xl mx-auto px-4 py-4 flex justify-between items-center">
        <div className="flex items-center gap-8">
          <h1 className="text-3xl font-bold">🔥 The Ovens Secret</h1>
          <ul className="hidden md:flex gap-6">
            <li>
              <a href="/" className="hover:text-amber-200 transition">
                Home
              </a>
            </li>
            <li>
              <a href="/recipes" className="hover:text-amber-200 transition">
                Recipes
              </a>
            </li>
            <li>
              <a href="/about" className="hover:text-amber-200 transition">
                About
              </a>
            </li>
            <li>
              <a href="/contact" className="hover:text-amber-200 transition">
                Contact
              </a>
            </li>
          </ul>
        </div>
      </nav>
    </header>
  );
}
