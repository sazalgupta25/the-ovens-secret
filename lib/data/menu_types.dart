/// Menu data types — identical to Next.js categories/types.ts

class MenuItem {
  final String name;
  final int price; // in ₹
  final String? priceNote; // e.g. "per piece"

  const MenuItem({required this.name, required this.price, this.priceNote});
}

class MenuSection {
  final String title;
  final String? servingSize;
  final List<MenuItem> items;
  final String? note;

  const MenuSection({
    required this.title,
    this.servingSize,
    required this.items,
    this.note,
  });
}

class MenuCategory {
  final String id;
  final String title;
  final String emoji;
  final List<MenuSection> sections;

  const MenuCategory({
    required this.id,
    required this.title,
    required this.emoji,
    required this.sections,
  });
}
