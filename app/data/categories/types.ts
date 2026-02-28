// =============================================================================
// Menu Data Type Definitions
// =============================================================================

export interface MenuItem {
  name: string;
  price: number; // in ₹
  priceNote?: string; // e.g., "per piece", "+ addon"
}

export interface MenuSection {
  title: string;
  servingSize?: string;
  items: MenuItem[];
  note?: string;
}

export interface MenuCategory {
  id: string;
  title: string;
  emoji: string;
  sections: MenuSection[];
}
