import Link from "next/link";
import Image from "next/image";

export default function Header() {
  return (
    <header className="header-bg text-stone-200 shadow-lg sticky top-0 z-50">
      <nav className="max-w-6xl mx-auto px-4 py-4 flex justify-between items-center">
        <div className="flex items-center gap-8">
          <Link href="/" className="text-3xl font-bold hover:text-stone-300 transition flex items-center">
            <Image src="/3.png" alt="The Oven's Secret" width={40} height={40} className="inline-block mr-2" />
            The Ovens Secret
          </Link>
          <ul className="hidden md:flex gap-6 font-semibold">
            <li>
              <Link
                href="/"
                className="hover:text-stone-300 transition duration-200"
              >
                Home
              </Link>
            </li>
            <li>
              <Link
                href="/menu"
                className="hover:text-stone-300 transition duration-200"
              >
                Menu
              </Link>
            </li>
            <li>
              <a
                href="/recipes"
                className="hover:text-stone-300 transition duration-200"
              >
                Recipes
              </a>
            </li>
            <li>
              <a
                href="/about"
                className="hover:text-stone-300 transition duration-200"
              >
                About
              </a>
            </li>
            <li>
              <a
                href="/contact"
                className="hover:text-stone-300 transition duration-200"
              >
                Contact
              </a>
            </li>
          </ul>
        </div>

        {/* Mobile Menu Indicator */}
        <div className="md:hidden">
          <button
            className="text-2xl hover:text-stone-300 transition"
            aria-label="Toggle menu"
          >
            ☰
          </button>
        </div>
      </nav>
    </header>
  );
}
