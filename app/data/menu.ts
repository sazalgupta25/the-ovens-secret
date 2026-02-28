// =============================================================================
// menu.ts — Menu aggregator
// Combines all menu categories into a single export
// =============================================================================

export type { MenuCategory, MenuSection, MenuItem } from "./categories/types";
export { businessInfo } from "./constants";

import {
  cakesCategory,
  specialCakesCategory,
  browniesCategory,
  cookiesCategory,
  chocolatesCategory,
  type MenuCategory,
} from "./categories";

// ============================================================================
// Full Menu Export
// ============================================================================
export const menu: MenuCategory[] = [
  cakesCategory,
  specialCakesCategory,
  browniesCategory,
  cookiesCategory,
  chocolatesCategory,
];
