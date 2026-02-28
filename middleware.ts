import { NextRequest, NextResponse } from "next/server";

// ============================================================================
// Security Middleware for Next.js
// ============================================================================

/**
 * Middleware runs for every request. Use this to add security headers,
 * implement rate limiting, authentication checks, etc.
 */
export function middleware(request: NextRequest) {
  const response = NextResponse.next();

  // =========== Security Headers ===========

  // Remove server signature
  response.headers.set("X-Powered-By", "");

  // Prevent MIME type sniffing
  response.headers.set("X-Content-Type-Options", "nosniff");

  // Prevent clickjacking attacks
  response.headers.set("X-Frame-Options", "SAMEORIGIN");

  // Enable XSS protection (older browsers)
  response.headers.set("X-XSS-Protection", "1; mode=block");

  // Limit information disclosure
  response.headers.set("Referrer-Policy", "strict-origin-when-cross-origin");

  // Restrict API access
  response.headers.set(
    "Permissions-Policy",
    "camera=(), microphone=(), geolocation=(), payment=()"
  );

  // Content Security Policy (basic)
  // Adjust as needed for your application
  response.headers.set(
    "Content-Security-Policy",
    "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' https:; frame-ancestors 'none';"
  );

  // Strict Transport Security (HTTPS)
  // Only enable this after verifying HTTPS is configured
  if (process.env.NODE_ENV === "production") {
    response.headers.set("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
  }

  // =========== CORS Headers ===========
  // Only allow same-origin by default
  const origin = request.headers.get("origin");
  if (origin && process.env.ALLOWED_ORIGINS?.includes(origin)) {
    response.headers.set("Access-Control-Allow-Origin", origin);
    response.headers.set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    response.headers.set("Access-Control-Allow-Headers", "Content-Type, Authorization");
  }

  return response;
}

/**
 * Configure which routes middleware should run on
 * You can use regex patterns for more complex matching
 */
export const config = {
  matcher: [
    // Run on all routes except static files and api routes
    "/((?!_next/static|_next/image|favicon.ico).*)",
  ],
};
