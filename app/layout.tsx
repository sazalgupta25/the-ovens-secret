import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
  display: "swap",
  preload: true,
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
  display: "swap",
});

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  userScalable: true,
  colorScheme: "light",
};

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_BASE_URL || "https://theovenssecret.com"),
  title: {
    default: process.env.NEXT_PUBLIC_APP_NAME || "The Ovens Secret - Premium Artisan Breads",
    template: "%s | The Ovens Secret",
  },
  description:
    process.env.NEXT_PUBLIC_APP_DESCRIPTION ||
    "Discover premium artisan breads, sourdough, and baking techniques. Learn from expert bakers at The Ovens Secret.",
  keywords: [
    "artisan bakery",
    "sourdough bread",
    "premium bread",
    "bread recipes",
    "baking techniques",
    "fermented bread",
    "focaccia",
    "whole wheat bread",
    "artisan sourdough",
    "handmade bread",
  ],
  authors: [
    {
      name: "The Ovens Secret Team",
      url: "https://theovenssecret.com",
    },
  ],
  creator: "The Ovens Secret",
  publisher: "The Ovens Secret",
  formatDetection: {
    email: true,
    address: true,
    telephone: true,
  },
  icons: {
    icon: "/favicon.ico",
    shortcut: "/favicon-16x16.png",
    apple: "/apple-touch-icon.png",
  },
  manifest: "/site.webmanifest",
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "https://theovenssecret.com",
    siteName: "The Ovens Secret",
    title: "The Ovens Secret - Premium Artisan Breads",
    description: "Discover handcrafted artisan breads and expert baking techniques",
    images: [
      {
        url: "/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "The Ovens Secret - Premium Artisan Breads",
        type: "image/jpeg",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "The Ovens Secret - Premium Artisan Breads",
    description: "Discover handcrafted breads and expert baking techniques",
    images: ["/og-image.jpg"],
    creator: "@theovenssecret",
  },
  robots: {
    index: true,
    follow: true,
    nocache: false,
    googleBot: {
      index: true,
      follow: true,
      noimageindex: false,
      "max-image-preview": "large",
      "max-snippet": -1,
      "max-video-preview": -1,
    },
  },
  alternates: {
    canonical: "https://theovenssecret.com",
    languages: {
      "en-US": "https://theovenssecret.com",
    },
  },
  referrer: "origin-when-cross-origin",
  appleWebApp: {
    capable: true,
    statusBarStyle: "black-translucent",
    title: "The Ovens Secret",
  },
  category: "food",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="scroll-smooth">
      <head>
        {/* Preload critical fonts */}
        <link
          rel="preload"
          as="font"
          href="https://fonts.googleapis.com/css2?family=Geist:wght@400;500;600;700&display=swap"
          type="font/woff2"
          crossOrigin="anonymous"
        />

        {/* DNS prefetch for external resources */}
        <link rel="dns-prefetch" href="https://fonts.googleapis.com" />
        <link rel="dns-prefetch" href="https://fonts.gstatic.com" />

        {/* Preconnect for essential resources */}
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />

        {/* Web App Manifest */}
        <link rel="manifest" href="/site.webmanifest" />

        {/* Theme color */}
        <meta name="theme-color" content="#78350f" />
      </head>
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased bg-white text-gray-900`}
      >
        <a href="#main-content" className="sr-only focus:not-sr-only">
          Skip to main content
        </a>
        {children}
      </body>
    </html>
  );
}
