# Components API Documentation

## Shared Components

This document describes all reusable components in the `/app/components/shared` directory.

---

## Button

Reusable button component with variants, sizes, and loading states.

### Props

```typescript
interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "danger" | "ghost";  // Default: "primary"
  size?: "sm" | "md" | "lg";                              // Default: "md"
  isLoading?: boolean;                                    // Default: false
  children: React.ReactNode;
}
```

### Usage

```tsx
import { Button } from "@/app/components/shared";

// Primary button
<Button onClick={handleClick}>Submit</Button>

// Secondary button
<Button variant="secondary">Cancel</Button>

// Small button
<Button size="sm">Small</Button>

// Loading state
<Button isLoading>Submitting...</Button>

// Disabled button
<Button disabled>Disabled</Button>

// Custom className
<Button className="w-full">Full Width</Button>
```

### Variants

1. **primary** (default): Red background with white text
2. **secondary**: Light background with dark text and border
3. **danger**: Red background (for destructive actions)
4. **ghost**: Transparent background (minimal style)

### Sizes

1. **sm**: Small padding, small font size
2. **md** (default): Medium padding, base font size
3. **lg**: Large padding, large font size

---

## FormInput

Text input component with label, error handling, and helper text.

### Props

```typescript
interface FormInputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;           // Input label
  error?: string;           // Error message to display
  helperText?: string;      // Helper text below input
  fullWidth?: boolean;      // Default: true
}
```

### Usage

```tsx
import { FormInput } from "@/app/components/shared";

// Basic input
<FormInput
  type="text"
  name="username"
  label="Username"
  placeholder="Enter username"
/>

// With error
<FormInput
  type="email"
  name="email"
  label="Email"
  error="Invalid email address"
/>

// With helper text
<FormInput
  type="password"
  name="password"
  label="Password"
  helperText="Must be at least 8 characters"
  required
/>

// Disabled input
<FormInput
  type="text"
  label="Disabled"
  disabled
  value="Cannot edit"
/>
```

### Features

- Automatic error styling (red border, red text)
- Helper text display below input
- Required indicator (*) on label
- Full-width by default
- Disabled state styling

---

## FormTextarea

Textarea component with label, error handling, and helper text.

### Props

```typescript
interface FormTextareaProps extends TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;           // Input label
  error?: string;           // Error message to display
  helperText?: string;      // Helper text below textarea
  fullWidth?: boolean;      // Default: true
}
```

### Usage

```tsx
import { FormTextarea } from "@/app/components/shared";

// Basic textarea
<FormTextarea
  name="message"
  label="Message"
  placeholder="Enter your message"
  rows={5}
/>

// With error
<FormTextarea
  name="feedback"
  label="Feedback"
  error="Message is too short"
/>

// With validation
<FormTextarea
  name="description"
  label="Description"
  maxLength={500}
  required
/>
```

### Features

- Resizable (vertical only by default)
- Error and helper text support
- Row configuration
- Max length validation
- Disabled state styling

---

## NavLink

Navigation link component with active state support.

### Props

```typescript
interface NavLinkProps {
  href: string;              // Link destination
  children: ReactNode;       // Link text
  isActive?: boolean;        // Set active state
  className?: string;        // Additional classes
}
```

### Usage

```tsx
import { NavLink } from "@/app/components/shared";

// Basic link
<NavLink href="/menu">Menu</NavLink>

// Active link with styling
<NavLink href="/menu" isActive={currentPath === "/menu"}>
  Menu
</NavLink>

// With custom className
<NavLink href="/recipes" className="text-lg">
  Recipes
</NavLink>
```

### Features

- Automatic active state styling
- Border bottom indicator for active links
- Hover effects
- Integrates with Next.js Link

---

## Page Components

### Header

Navigation header component displayed on all pages.

**Location**: `app/components/Header.tsx`

**Features**:
- Logo/branding
- Navigation menu
- Mobile menu toggle (button only)
- Sticky positioning

---

### Footer

Footer component with links and information.

**Location**: `app/components/Footer.tsx`

**Features**:
- Contact information
- Links section
- Social media links
- Copyright notice

---

### MenuPreviewCard

Menu preview card displayed on home page.

**Location**: `app/components/MenuPreviewCard.tsx`

**Features**:
- Category grid
- Price range display
- "View Full Menu" CTA
- WhatsApp integration

---

## Usage Examples

### Form with Validation

```tsx
import { FormInput, FormTextarea, Button } from "@/app/components/shared";
import { useState } from "react";

export function ContactForm() {
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    
    // Validate and submit
    const response = await fetch("/api/contact", {
      method: "POST",
      body: JSON.stringify(formData),
    });
    
    setIsLoading(false);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <FormInput
        label="Name"
        name="name"
        error={errors.name}
        required
      />
      <FormTextarea
        label="Message"
        name="message"
        error={errors.message}
        rows={5}
        required
      />
      <Button isLoading={isLoading} type="submit">
        Send Message
      </Button>
    </form>
  );
}
```

### Navigation

```tsx
import { NavLink } from "@/app/components/shared";
import { usePathname } from "next/navigation";

export function Navigation() {
  const pathname = usePathname();

  return (
    <nav className="flex gap-6">
      <NavLink href="/" isActive={pathname === "/"}>
        Home
      </NavLink>
      <NavLink href="/menu" isActive={pathname === "/menu"}>
        Menu
      </NavLink>
      <NavLink href="/recipes" isActive={pathname === "/recipes"}>
        Recipes
      </NavLink>
    </nav>
  );
}
```

---

## Styling

All components use **Tailwind CSS** with a custom color palette:

- **Primary**: `#c0392b` (Red)
- **Background**: `#fdf6ee` (Light sand)
- **Text**: `#5c2d1e` (Dark brown)
- **Border**: `#f0ddc0` (Light beige)

Custom colors are defined in `app/data/constants.ts`.

---

## Testing Components

### Example Test

```typescript
import { render, screen } from "@testing-library/react";
import { Button } from "@/app/components/shared";

describe("Button Component", () => {
  it("renders button with text", () => {
    render(<Button>Click me</Button>);
    expect(screen.getByRole("button", { name: /click me/i })).toBeInTheDocument();
  });

  it("handles click events", () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click</Button>);
    screen.getByRole("button").click();
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

---

## Accessibility

All components follow WCAG 2.1 guidelines:

- Proper semantic HTML (`<button>`, `<input>`, `<label>`)
- ARIA attributes where needed
- Keyboard navigation support
- Screen reader friendly
- Sufficient color contrast
- Focus indicators

---

## Future Components

Planned components to add:

- [ ] Card component
- [ ] Modal/Dialog
- [ ] Toast notifications
- [ ] Dropdown menu
- [ ] Pagination
- [ ] Breadcrumbs
- [ ] Search input
- [ ] Select dropdown
- [ ] Checkbox/Radio
- [ ] Loading spinner

---

**Last Updated**: 2026-02-28  
**Component Library Version**: 1.0
