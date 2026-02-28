// ============================================================================
// Security Utilities
// ============================================================================

/**
 * Sanitize HTML content to prevent XSS attacks
 * Note: In production, use a library like DOMPurify
 */
export function sanitizeHtml(html: string): string {
  const escapeMap: Record<string, string> = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': "&quot;",
    "'": "&#x27;",
    "/": "&#x2F;",
  };

  return html.replace(/[&<>"'/]/g, (char) => escapeMap[char]);
}

/**
 * Validate URL to prevent malicious redirects
 */
export function isValidRedirectUrl(url: string): boolean {
  try {
    const urlObj = new URL(url, "http://localhost");
    // Only allow same-origin redirects
    return urlObj.origin === new URL("http://localhost").origin;
  } catch {
    return false;
  }
}

/**
 * Rate limiting helper (in-memory, simple implementation)
 */
const rateLimitStore = new Map<
  string,
  { count: number; resetTime: number }
>();

export function checkRateLimit(
  identifier: string,
  limit: number = 10,
  windowMs: number = 60000 // 1 minute
): boolean {
  const now = Date.now();
  const current = rateLimitStore.get(identifier);

  if (!current || now > current.resetTime) {
    rateLimitStore.set(identifier, { count: 1, resetTime: now + windowMs });
    return true;
  }

  if (current.count >= limit) {
    return false;
  }

  current.count++;
  return true;
}

/**
 * Get client IP address from request headers
 */
export function getClientIp(request: Request): string {
  const headers = new Headers(request.headers);
  return (
    headers.get("x-forwarded-for")?.split(",")[0].trim() ||
    headers.get("x-real-ip") ||
    headers.get("cf-connecting-ip") ||
    "unknown"
  );
}

/**
 * Validate email format
 */
export function isValidEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

/**
 * Validate phone number format
 */
export function isValidPhoneNumber(phone: string): boolean {
  return /^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$/.test(phone);
}

/**
 * Hash a string using Node.js crypto (for password hashing, use bcrypt in production)
 */
export async function hashString(str: string): Promise<string> {
  const encoder = new TextEncoder();
  const data = encoder.encode(str);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map((b) => b.toString(16).padStart(2, "0")).join("");
}

/**
 * Generate a random secure token
 */
export function generateToken(length: number = 32): string {
  const array = new Uint8Array(length);
  crypto.getRandomValues(array);
  return Array.from(array, (byte) => byte.toString(16).padStart(2, "0")).join("");
}

/**
 * Log security events
 */
export function logSecurityEvent(event: {
  type: "rate_limit" | "invalid_input" | "unauthorized" | "error";
  timestamp: Date;
  details: string;
  ip?: string;
}): void {
  console.warn(`[SECURITY] ${event.type}:`, {
    timestamp: event.timestamp.toISOString(),
    details: event.details,
    ip: event.ip || "unknown",
  });

  // TODO: In production, send to security monitoring service
  // Example: Sentry, DataDog, or custom logging service
}
