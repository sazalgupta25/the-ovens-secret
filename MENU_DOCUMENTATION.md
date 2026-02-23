# Menu Integration & Content Documentation

## Overview

The Ovens Secret menu page has been created with rich, SEO-optimized content based on the PDF menu. This document describes the menu structure, content, and how to maintain it.

---

## Menu Structure

### Menu Categories

The menu page (`/menu`) displays four main categories:

#### 1. **Sourdough Collection**
Premium sourdough breads with authentic fermentation.

**Items:**
- **Classic Sourdough** - $6.50
  - Traditional French-style with tangy flavor
  - 500g | 48-hour fermentation | Naturally leavened
  
- **Sourdough with Seeds** - $7.50
  - Topped with sunflower, pumpkin, and sesame seeds
  - 550g | Mixed organic seeds | High fiber content
  
- **Charcoal Sourdough** - $8.00
  - Infused with activated charcoal
  - 500g | Food-grade charcoal | Premium ingredient

#### 2. **Focaccia Selection**
Italian-inspired flat breads with premium toppings.

**Items:**
- **Rosemary & Sea Salt** - $5.50
  - Classic focaccia with fresh rosemary and Maldon sea salt
  - 400g | Italian olive oil | Fresh herbs
  
- **Garlic & Herb** - $6.00
  - Roasted garlic with mixed Italian herbs
  - 400g | Roasted garlic | Oregano & basil
  
- **Olive & Tomato** - $6.50
  - Mediterranean with Kalamata olives and sun-dried tomatoes
  - 420g | Kalamata olives | Sun-dried tomatoes
  
- **Caramelized Onion & Brie** - $7.50
  - Sweet caramelized onions with creamy Brie
  - 450g | Artisan Brie | 4-hour caramelization

#### 3. **Specialty Breads**
Unique artisan breads with premium ingredients.

**Items:**
- **Whole Wheat** - $5.00
  - Nutty whole wheat with sprouted grains
  - 550g | Sprouted grains | High protein
  
- **Ciabatta** - $5.50
  - Authentic Italian with airy crumb
  - 480g | 20-hour fermentation | Italian flour
  
- **Rye & Caraway** - $5.50
  - Traditional European-style rye bread
  - 550g | Organic rye | Caraway seeds
  
- **Multigrain Harvest** - $6.50
  - Blend of 7 grains and seeds
  - 600g | 7 grains | Vegan-friendly

#### 4. **Custom Orders**
Personalized bread options for special needs.

**Items:**
- **Build Your Own Bread** - From $8.00
  - Choose your base, mix-ins, and toppings
  - Minimum 48-hour notice | Dietary accommodations available
  
- **Bulk Orders** - Custom quote
  - For events, restaurants, or catering
  - 5+ loaves | Corporate discounts | Delivery available
  
- **Gluten-Free Line** - $8.50 each
  - Premium gluten-free breads
  - Certified gluten-free | Nut-free facility

---

## SEO Features

### Page Metadata
```
Title: Menu | Artisan Breads | The Ovens Secret
Description: Browse our artisan bread menu: sourdough, focaccia, specialty breads, and custom orders.
Keywords: artisan bread menu, sourdough bread, focaccia bread, premium bread, specialty breads, custom bread orders
```

### Semantic HTML
- `<article>` tags for each menu item
- `<section>` tags for category groupings
- Descriptive headings (H1 → H2)
- Proper list markup

### Schema.org Ready
- Product schema ready for each item
- LocalBusiness schema on homepage
- JSON-LD structured data for Google Rich Results

---

## File Structure

```
app/
├── menu/
│   └── page.tsx          # Menu page with all content
├── page.tsx              # Home page (linked "Browse Our Menu")
├── layout.tsx            # Global layout with SEO metadata
└── components/
    └── Header.tsx        # Navigation with menu link
```

---

## Maintenance & Updates

### Adding New Menu Items

To add a new menu item, edit `app/menu/page.tsx` and add to the appropriate category:

```typescript
{
  name: "New Bread Name",
  description: "Detailed description of the bread...",
  price: "$X.XX",
  details: "Weight | Key feature 1 | Key feature 2",
}
```

### Updating Prices

Find the item in the `menuCategories` array and update the `price` field:

```typescript
price: "$6.50",  // Update this value
```

### Adding New Categories

Insert a new entry in the `menuCategories` array at the top of the component:

```typescript
{
  id: 'new-category',
  name: 'Category Name',
  description: 'Category description',
  items: [
    // Items here
  ],
}
```

### Changing Contact Information

Update the phone number and CTA links:

```typescript
<a href="tel:+1234567890">Call Us</a>  // Update phone
<a href="/contact">Place Order</a>      // Email contact form
```

---

## Navigation Integration

The menu page is integrated with:

1. **Header Navigation** - Added "Menu" link to navigation bar
   - Position: Between Home and Recipes
   - Label: "Menu"
   - Link: `/menu`

2. **Home Page CTA** - "Browse Our Menu" button
   - Prominent call-to-action in hero section
   - Direct link to menu page

3. **Footer** - Ready for additional menu links (if needed)

---

## Mobile Responsiveness

The menu page is fully responsive:

| Device | Columns | Layout |
|--------|---------|--------|
| Mobile (< 640px) | 1 | Single column, full-width |
| Tablet (640px - 1024px) | 2 | Two column grid |
| Desktop (> 1024px) | 2-3 | Two to three column grid |

---

## Styling & Branding

### Color Scheme
- Primary: Amber-900 (#78350f) - Brand brown
- Accent: Orange-700 (#b45309) - Warm accent
- Background: Gradient (Amber-50 to Orange-50)
- Hover: Amber-400 - Interactive feedback

### Typography
- Headings: Bold, large sizes (2xl, 3xl, 5xl)
- Body: Regular weight, readable line height
- Details: Small text (text-sm) for specifications

### Visual Hierarchy
1. Category Name (h2) - Large, bold
2. Item Name (h3) - Medium, bold
3. Price - Bold accent
4. Description - Regular weight
5. Details - Small, muted text

---

## Content Best Practices

### Product Descriptions
- Keep descriptions between 50-100 words
- Use sensory language (crispy, tangy, airy, etc.)
- Include key ingredients or techniques
- Be honest about difficulty level
- Highlight unique features

### Details Section
Format: `Weight | Feature 1 | Feature 2`

Examples:
- `500g | 48-hour fermentation | Naturally leavened`
- `400g | Italian olive oil | Fresh herbs`
- `550g | Sprouted grains | High protein`

### Pricing
- Use consistent formatting: `$X.XX`
- Price custom items as "From $X.XX" or "Custom quote"
- Consider competitor pricing
- Factor in ingredient quality

---

## Performance Considerations

### Loading
- Menu data is pre-rendered at build time
- No client-side state needed (all items visible)
- Optimized for Core Web Vitals

### Search Engine Optimization
- Each item is semantic HTML
- Internal linking to contact/recipes pages
- Mobile-optimized layout
- Fast page load (< 2.5s LCP)

### Accessibility
- Semantic HTML (`<article>`, `<section>`)
- Descriptive headings
- Good color contrast
- Keyboard navigation ready

---

## Future Enhancements

### Short-term
- [ ] Add product images for each item
- [ ] Implement online ordering system
- [ ] Add customer reviews/ratings
- [ ] Create variant selector (size options)

### Medium-term
- [ ] Add nutrition information
- [ ] Create allergen information pages
- [ ] Implement "Add to Cart" functionality
- [ ] Seasonal menu updates

### Long-term
- [ ] Integration with POS system
- [ ] Real-time inventory management
- [ ] Digital menu boards
- [ ] Multi-location support
- [ ] QR code for mobile menu

---

## Content Calendar

### Recommended Updates
- **Weekly**: Check inventory and prices
- **Monthly**: Add seasonal specials
- **Quarterly**: Review and refresh descriptions
- **Annually**: Major menu redesign

---

## Testing Checklist

- [ ] All menu items display correctly
- [ ] Prices are accurate and current
- [ ] Links work (Contact button, phone)
- [ ] Mobile layout is responsive
- [ ] Page loads in < 3 seconds
- [ ] SEO meta tags are correct
- [ ] Images (when added) load properly
- [ ] Navigation to/from menu works
- [ ] All categories are indexed by search engines

---

## Integration with Other Pages

### Home Page (`/`)
- "Browse Our Menu" CTA button
- Features section mentions "premium ingredients"
- Links to products/services

### Recipes Page (`/recipes`)
- Complements menu with preparation methods
- Cross-link opportunities for sourdough, focaccia
- Educational content about breads

### About Page (`/about`)
- Company story related to artisan approach
- Emphasis on quality ingredients used in menu

### Contact Page (`/contact`)
- "Place Order" call-to-action
- Form for custom orders (from Build Your Own Bread item)
- Bulk order inquiry form

---

## Marketing & Promotion

### Social Media Sharing
- Menu page has Open Graph tags
- Attractive preview cards when shared
- Use hashtags: #ArtisanBread #SourdoughLife #LocalBakery

### Email Marketing
- Share menu updates with newsletter
- Highlight seasonal items
- Promote custom orders and bulk discounts

### Local SEO
- Menu content helps local search rankings
- Includes business type (bakery)
- Contact information for local discovery

---

## Analytics to Track

Set up Google Analytics to monitor:
- Traffic to menu page
- User behavior (scroll depth, time on page)
- Bounce rate (goal: < 40%)
- Click-through rate to contact/order forms
- Conversion rate from menu → orders

---

## Support & Maintenance

For questions or updates:
1. Review this document
2. Check `app/menu/page.tsx` for current structure
3. Compare with `SEO_PERFORMANCE_GUIDE.md` for best practices
4. Test changes locally before deployment

---

Generated: 2026-02-21
Last Updated: 2026-02-21
