"use client";

import Header from "../components/Header";
import Footer from "../components/Footer";
import { useState, ChangeEvent, FormEvent } from "react";
import type React from "react";

export default function ContactPage() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    subject: "",
    message: "",
  });

  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState<{ type: "success" | "error"; text: string } | null>(
    null
  );

  const handleChange = (
    e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setMessage(null);

    try {
      const response = await fetch("/api/contact", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Failed to send message");
      }

      setMessage({
        type: "success",
        text: data.message || "Thank you for your message! We'll get back to you soon.",
      });
      setFormData({ name: "", email: "", subject: "", message: "" });
    } catch (error) {
      setMessage({
        type: "error",
        text: error instanceof Error ? error.message : "An error occurred. Please try again.",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main className="max-w-6xl mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold text-amber-900 mb-8">Contact Us</h1>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
          {/* Contact Information */}
          <div>
            <h2 className="text-2xl font-bold text-amber-900 mb-6">
              Get in Touch
            </h2>
            <div className="space-y-6 mb-8">
              <div>
                <h3 className="text-lg font-semibold text-amber-900 mb-2">
                  Email
                </h3>
                <p className="text-gray-600">info@theovens-secret.com</p>
              </div>
              <div>
                <h3 className="text-lg font-semibold text-amber-900 mb-2">
                  Address
                </h3>
                <p className="text-gray-600">The Ovens Secret Headquarters</p>
                <p className="text-gray-600">Baking Street, Artisan City</p>
              </div>
              <div>
                <h3 className="text-lg font-semibold text-amber-900 mb-2">
                  Follow Us
                </h3>
                <div className="flex gap-4">
                  <a
                    href="https://www.facebook.com/priyakakhazana"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-amber-900 hover:text-amber-700 transition"
                  >
                    Facebook
                  </a>
                  <a
                    href="https://www.instagram.com/_the_ovens_secret/"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-amber-900 hover:text-amber-700 transition"
                  >
                    Instagram
                  </a>
                  <a
                    href="https://www.youtube.com/c/priyakakhazana"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-amber-900 hover:text-amber-700 transition"
                  >
                    Youtube
                  </a>
                </div>
              </div>
            </div>
          </div>

          {/* Contact Form */}
          <div>
            {message && (
              <div
                className={`mb-4 p-4 rounded-lg ${
                  message.type === "success"
                    ? "bg-green-100 text-green-800 border border-green-300"
                    : "bg-red-100 text-red-800 border border-red-300"
                }`}
              >
                {message.text}
              </div>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-1">
                  Name
                </label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  disabled={loading}
                  required
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-amber-900 disabled:bg-gray-100 disabled:cursor-not-allowed"
                  placeholder="Your name"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-1">
                  Email
                </label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  disabled={loading}
                  required
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-amber-900 disabled:bg-gray-100 disabled:cursor-not-allowed"
                  placeholder="your@email.com"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-1">
                  Subject
                </label>
                <input
                  type="text"
                  name="subject"
                  value={formData.subject}
                  onChange={handleChange}
                  disabled={loading}
                  required
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-amber-900 disabled:bg-gray-100 disabled:cursor-not-allowed"
                  placeholder="Subject"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-1">
                  Message
                </label>
                <textarea
                  name="message"
                  value={formData.message}
                  onChange={handleChange}
                  disabled={loading}
                  required
                  rows={5}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-amber-900 disabled:bg-gray-100 disabled:cursor-not-allowed"
                  placeholder="Your message..."
                />
              </div>
              <button
                type="submit"
                disabled={loading}
                className="w-full bg-amber-900 text-white font-semibold py-2 rounded-lg hover:bg-amber-800 transition disabled:bg-gray-400 disabled:cursor-not-allowed"
              >
                {loading ? "Sending..." : "Send Message"}
              </button>
            </form>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
