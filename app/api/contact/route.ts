import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { Resend } from "resend";
import { getClientIp, logSecurityEvent } from "@/app/lib/security";

// ============================================================================
// Contact Form Validation Schema
// ============================================================================
const ContactFormSchema = z.object({
  name: z
    .string()
    .min(2, "Name must be at least 2 characters")
    .max(100, "Name must be less than 100 characters")
    .trim(),
  email: z.string().email("Invalid email address").toLowerCase(),
  subject: z
    .string()
    .min(3, "Subject must be at least 3 characters")
    .max(200, "Subject must be less than 200 characters")
    .trim(),
  message: z
    .string()
    .min(10, "Message must be at least 10 characters")
    .max(5000, "Message must be less than 5000 characters")
    .trim(),
});

type ContactFormData = z.infer<typeof ContactFormSchema>;

// ============================================================================
// Email Service (using Resend)
// ============================================================================
async function sendEmail(data: ContactFormData): Promise<{ success: boolean; error?: any }> {
  if (!process.env.RESEND_API_KEY) {
    console.error("RESEND_API_KEY is not set. Cannot send email.");
    return { success: false, error: "Email service is not configured." };
  }

  const resend = new Resend(process.env.RESEND_API_KEY);
  const toEmail = process.env.CONTACT_EMAIL_TO || "contact@theovenssecret.com";

  try {
    const result = await resend.emails.send({
      from: "contact@theovenssecret.com",
      to: toEmail,
      replyTo: data.email,  
      subject: `New Contact Form: ${data.subject}`,
      html: `
        <h2>New Contact Form Submission</h2>
        <p><strong>Name:</strong> ${data.name}</p>
        <p><strong>Email:</strong> ${data.email}</p>
        <p><strong>Subject:</strong> ${data.subject}</p>
        <p><strong>Message:</strong></p>
        <p>${data.message.replace(/\n/g, "<br>")}</p>
      `,
    });

    if (result.error) {
      console.error("Resend API error:", result.error);
      return { success: false, error: result.error };
    }

    return { success: true };
  } catch (error) {
    console.error("Email send error:", error);
    return { success: false, error };
  }
}

// ============================================================================
// Rate Limiting (moved from utils to here)
// ============================================================================
const rateLimitStore = new Map<string, { count: number; resetTime: number }>();

function checkContactRateLimit(identifier: string): boolean {
  const now = Date.now();
  const current = rateLimitStore.get(identifier);

  if (!current || now > current.resetTime) {
    rateLimitStore.set(identifier, { count: 1, resetTime: now + 3600000 }); // 1 hour
    return true;
  }

  if (current.count >= 5) {
    // 5 requests per hour per IP
    return false;
  }

  current.count++;
  return true;
}

// ============================================================================
// POST Handler
// ============================================================================
export async function POST(request: NextRequest) {
  try {
    // Get client IP for rate limiting and logging
    const clientIP = getClientIp(request);

    // Check rate limit (5 requests per hour per IP)
    if (!checkContactRateLimit(clientIP)) {
      logSecurityEvent({
        type: "rate_limit",
        timestamp: new Date(),
        details: "Contact form rate limit exceeded",
        ip: clientIP,
      });

      return NextResponse.json(
        { error: "Too many requests. Please try again later." },
        { status: 429 }
      );
    }

    // Parse and validate request body
    const body = await request.json();
    const validatedData = ContactFormSchema.parse(body);

    // Send email
    const emailResult = await sendEmail(validatedData);

    if (!emailResult.success) {
      logSecurityEvent({
        type: "error",
        timestamp: new Date(),
        details: "Email send failed",
        ip: clientIP,
      });

      return NextResponse.json(
        { error: "Failed to send email. Please try again later." },
        { status: 500 }
      );
    }

    return NextResponse.json(
      {
        success: true,
        message: "Thank you for your message! We'll get back to you soon.",
      },
      { status: 200 }
    );
  } catch (error) {
    // Handle validation errors
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        {
          error: "Validation failed",
          details: error.issues.map((e) => ({
            field: e.path.join("."),
            message: e.message,
          })),
        },
        { status: 400 }
      );
    }

    // Handle JSON parsing errors
    if (error instanceof SyntaxError) {
      return NextResponse.json(
        { error: "Invalid JSON in request body" },
        { status: 400 }
      );
    }

    console.error("Unexpected error in contact form:", error);
    return NextResponse.json(
      { error: "An unexpected error occurred. Please try again later." },
      { status: 500 }
    );
  }
}

// ============================================================================
// OPTIONS Handler (CORS)
// ============================================================================
export async function OPTIONS() {
  return NextResponse.json(
    {},
    {
      status: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type",
      },
    }
  );
}
