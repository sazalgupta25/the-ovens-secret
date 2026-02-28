"use client";

import { useEffect } from "react";
import Header from "./components/Header";
import Footer from "./components/Footer";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log the error to an error reporting service
    console.error(error);
  }, [error]);

  return (
    <div className="min-h-screen bg-white flex flex-col">
      <Header />
      <main className="flex-1 flex items-center justify-center px-4">
        <div className="max-w-md text-center py-20">
          <h1 className="text-5xl font-bold text-amber-900 mb-4">Oops!</h1>
          <p className="text-gray-600 mb-6">
            Something went wrong. Our team has been notified and is working on a fix.
          </p>
          <p className="text-sm text-gray-500 mb-8">
            Error ID: {error.digest || "unknown"}
          </p>
          <button
            onClick={() => reset()}
            className="bg-amber-900 text-white font-semibold py-3 px-8 rounded-lg hover:bg-amber-800 transition inline-block"
          >
            Try Again
          </button>
          <button
            onClick={() => (window.location.href = "/")}
            className="ml-4 text-amber-900 font-semibold py-3 px-8 rounded-lg border-2 border-amber-900 hover:bg-amber-50 transition inline-block"
          >
            Go Home
          </button>
        </div>
      </main>
      <Footer />
    </div>
  );
}
