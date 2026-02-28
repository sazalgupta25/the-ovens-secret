# Project Architecture

## Overview

The Ovens Secret is built with **Next.js 16** using the **App Router** and follows a modular, scalable architecture optimized for maintainability and performance.

---

## Directory Structure

```
.
├── app/
│   ├── api/                      # API Routes
│   │   ├── contact/route.ts      # Contact form endpoint
│   │   └── ...
│   ├── components/               # React Components
│   │   ├── shared/               # Reusable components
│   │   │   ├── Button.tsx
│   │   │   ├── FormInput.tsx
│   │   │   ├── FormTextarea.tsx
│   │   │   ├── NavLink.tsx
│   │   │   ├── __tests__/        # Component tests
│   │   │   └── index.ts
│   │   ├── Header.tsx
│   │   ├── Footer.tsx
│   │   └── MenuPreviewCard.tsx
│   ├── data/                     # Data & Constants
│   │   ├── categories/           # Menu categories
│   │   │   ├── types.ts          # Type definitions
│   │   │   ├── cakes.ts
│   │   │   ├── cookies.ts
│   │   │   ├── chocolates.ts
│   │   │   └── index.ts
│   │   ├── constants.ts          # App-wide constants
│   │   └── menu.ts               # Menu aggregator
│   ├── lib/                      # Utilities & Helpers
│   │   └── validation.ts         # Form validation schemas
│   ├── (routes)/                 # Page Routes
│   │   ├── page.tsx              # Home
│   │   ├── menu/page.tsx         # Menu
│   │   ├── recipes/page.tsx      # Recipes
│   │   ├── about/page.tsx        # About
│   │   └── contact/page.tsx      # Contact
│   ├── layout.tsx                # Root layout
│   ├── error.tsx                 # Error boundary
│   ├── not-found.tsx             # 404 page
│   ├── globals.css               # Global styles
│   └── robots.ts                 # SEO robots
├── public/                       # Static assets
├── docs/                         # Documentation
├── jest.config.ts                # Jest configuration
├── jest.setup.ts                 # Jest setup
├── next.config.ts                # Next.js configuration
├── tsconfig.json                 # TypeScript configuration
├── .prettierrc                   # Prettier configuration
├── eslint.config.mjs             # ESLint configuration
├── package.json                  # Dependencies
└── README.md                     # Project overview

```

---

## Architecture Layers

### 1. **Presentation Layer** (`app/components/`)
- **Shared Components**: Reusable UI components (Button, FormInput, NavLink)
- **Page Components**: Full-page components (Header, Footer, MenuPreviewCard)
- **Tests**: Unit tests for components

### 2. **Data Layer** (`app/data/`)
- **Categories**: Menu data split into logical modules
- **Constants**: Global application constants and business info
- **Types**: Shared TypeScript interfaces

### 3. **Business Logic Layer** (`app/lib/`, `app/api/`)
- **Validation**: Form validation schemas (Zod)
- **API Routes**: Server-side endpoints (Contact form handler)
- **Utilities**: Helper functions and utilities

### 4. **Routing Layer** (`app/`)
- **Page Routes**: Next.js App Router pages
- **Layouts**: Shared layout components
- **Error Handling**: Error boundary and 404 pages

---

## Key Design Patterns

### Component Composition
```tsx
// Shared components are imported and composed
import { Button, FormInput, FormTextarea } from "@/app/components/shared";

export function ContactForm() {
  return (
    <>
      <FormInput label="Name" name="name" required />
      <FormTextarea label="Message" name="message" required />
      <Button variant="primary">Submit</Button>
    </>
  );
}
```

### Data Management
- **Menu Data**: Split across multiple files for maintainability
- **Constants**: Centralized in `constants.ts`
- **Environment Variables**: Used for configuration

### API Patterns
```typescript
// Input validation with Zod
const schema = z.object({ email: z.string().email() });

// Error handling
try {
  const data = schema.parse(body);
  // Process data
} catch (error) {
  // Handle validation errors
}

// Rate limiting for security
checkRateLimit(clientIP, limit, windowMs);
```

---

## Data Flow

### Form Submission Flow
```
User Form → FormComponent → fetch(/api/contact) → Zod Validation
→ Rate Limiting → Email Service → Response → UI Feedback
```

### Menu Display Flow
```
menu.ts (aggregates) ← categories/*.ts ← types.ts
↓
useMenu Hook / Direct Import
↓
MenuPreviewCard / MenuPage Components
↓
Rendered to User
```

---

## Technology Stack

| Layer | Technology |
|-------|------------|
| **Framework** | Next.js 16 with App Router |
| **Language** | TypeScript 5 |
| **Styling** | Tailwind CSS 4 |
| **Validation** | Zod |
| **Testing** | Jest + React Testing Library |
| **Linting** | ESLint 9 |
| **Formatting** | Prettier 3 |
| **Runtime** | Node.js 22+ |

---

## Performance Optimizations

1. **Code Splitting**: Route-based code splitting with App Router
2. **Image Optimization**: Next.js Image component with AVIF/WebP
3. **Font Optimization**: Geist fonts with preloading and swap strategy
4. **Caching**: Browser cache headers and 1-year TTL for static assets
5. **Compression**: Gzip enabled, minified CSS/JS
6. **SEO**: Metadata optimization, sitemap, robots.txt

---

## Security Measures

1. **Input Validation**: Zod schemas for all forms
2. **Rate Limiting**: Simple IP-based rate limiting on APIs
3. **CORS Headers**: Proper CORS configuration
4. **Secure Defaults**: No powered-by headers, secure CSP
5. **HTTPS**: Enforced in production

---

## Development Workflow

### Local Setup
```bash
npm install
npm run dev                    # Start dev server
npm run lint                   # Check code quality
npm run format                 # Format code
npm test                       # Run tests
npm run build                  # Build for production
```

### Deployment
```bash
npm run build                  # Build optimized production bundle
npm start                      # Start production server
docker-compose up --build      # Docker deployment
```

---

## Testing Strategy

- **Unit Tests**: Component tests using Jest + React Testing Library
- **Integration Tests**: API route tests
- **E2E Tests**: Configured but not implemented yet

Example:
```typescript
describe("Button Component", () => {
  it("renders button with text", () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText("Click me")).toBeInTheDocument();
  });
});
```

---

## Scalability Considerations

1. **Menu Data**: Can scale to thousands of items
2. **Component Library**: Easily extendable shared components
3. **API Routes**: Can handle additional endpoints
4. **Database Ready**: Structure supports database integration
5. **Multi-Tenant Ready**: Can be adapted for multiple bakeries

---

## Future Enhancements

- [ ] Database integration (MongoDB / PostgreSQL)
- [ ] Authentication system (NextAuth.js)
- [ ] Payment processing (Stripe)
- [ ] Admin dashboard
- [ ] Order management system
- [ ] Customer reviews/ratings
- [ ] Blog/News section
- [ ] Advanced analytics

---

**Last Updated**: 2026-02-28  
**Architecture Version**: 1.0
