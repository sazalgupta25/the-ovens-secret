import { z } from "zod";

// ============================================================================
// Global Validation Schemas
// ============================================================================

/**
 * Contact Form Validation
 */
export const contactFormSchema = z.object({
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

export type ContactFormData = z.infer<typeof contactFormSchema>;

/**
 * Newsletter Subscription Validation
 */
export const newsletterSchema = z.object({
  email: z.string().email("Invalid email address").toLowerCase(),
});

export type NewsletterData = z.infer<typeof newsletterSchema>;

/**
 * Order Form Validation
 */
export const orderFormSchema = z.object({
  items: z.array(z.object({ id: z.string(), quantity: z.number().min(1) })).min(1),
  name: z
    .string()
    .min(2, "Name is required")
    .max(100)
    .trim(),
  phone: z.string().regex(/^\+?[0-9]{10,}$/, "Invalid phone number"),
  address: z.string().min(10, "Address is required").max(500),
  deliveryDate: z.date().min(new Date(), "Delivery date must be in the future"),
});

export type OrderFormData = z.infer<typeof orderFormSchema>;

/**
 * Validate form data against schema
 */
export function validateFormData<T>(schema: z.ZodSchema<T>, data: unknown): {
  success: boolean;
  data?: T;
  errors?: Record<string, string>;
} {
  try {
    const validatedData = schema.parse(data);
    return { success: true, data: validatedData };
  } catch (error) {
    if (error instanceof z.ZodError) {
      const errors: Record<string, string> = {};
      error.issues.forEach((err) => {
        const path = err.path.join(".");
        errors[path] = err.message;
      });
      return { success: false, errors };
    }
    return { success: false, errors: { general: "Validation failed" } };
  }
}
