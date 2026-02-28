import Header from "./components/Header";
import Footer from "./components/Footer";
import Link from "next/link";

export default function NotFound() {
  return (
    <div className="min-h-screen bg-white flex flex-col">
      <Header />
      <main className="flex-1 flex items-center justify-center px-4">
        <div className="max-w-md text-center py-20">
          <h1 className="text-6xl font-bold text-amber-900 mb-4">404</h1>
          <h2 className="text-2xl font-semibold text-gray-800 mb-4">Page Not Found</h2>
          <p className="text-gray-600 mb-8">
            The page you&rsquo;re looking for doesn&rsquo;t exist or has been moved.
          </p>
          <div className="space-x-4">
            <Link
              href="/"
              className="inline-block bg-amber-900 text-white font-semibold py-3 px-8 rounded-lg hover:bg-amber-800 transition"
            >
              Go Home
            </Link>
            <Link
              href="/menu"
              className="inline-block text-amber-900 font-semibold py-3 px-8 rounded-lg border-2 border-amber-900 hover:bg-amber-50 transition"
            >
              View Menu
            </Link>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
