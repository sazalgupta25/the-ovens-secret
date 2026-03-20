/// Recipe data — ported from Next.js recipes/page.tsx

class Recipe {
  final int id;
  final String title;
  final String description;
  final String difficulty;
  final String time;
  final String servings;
  final List<String> tags;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.time,
    required this.servings,
    required this.tags,
  });

  String get difficultyEmoji {
    switch (difficulty) {
      case 'Beginner':
        return '🌱';
      case 'Intermediate':
        return '🌾';
      case 'Advanced':
        return '🔥';
      default:
        return '';
    }
  }
}

const List<Recipe> recipes = [
  Recipe(
    id: 1,
    title: 'Classic Sourdough',
    description:
        'Traditional French-style sourdough with tangy flavor and crispy crust. Learn the perfect fermentation times and oven techniques.',
    difficulty: 'Intermediate',
    time: '24 hours',
    servings: '1 loaf',
    tags: ['sourdough', 'advanced', 'popular'],
  ),
  Recipe(
    id: 2,
    title: 'Focaccia Genovese',
    description:
        'Soft and aromatic Italian focaccia topped with olive oil and fresh rosemary. Perfect for beginners learning bread basics.',
    difficulty: 'Beginner',
    time: '4 hours',
    servings: '1 flatbread',
    tags: ['focaccia', 'italian', 'starter'],
  ),
  Recipe(
    id: 3,
    title: 'Ciabatta',
    description:
        'Authentic Italian ciabatta with a light, airy open crumb and crispy exterior. Advanced bakers will appreciate the high-hydration dough.',
    difficulty: 'Advanced',
    time: '18 hours',
    servings: '2 loaves',
    tags: ['ciabatta', 'italian', 'advanced'],
  ),
  Recipe(
    id: 4,
    title: 'Whole Wheat Bread',
    description:
        'Nutritious and hearty whole wheat loaf made with sprouted grains. Great for beginners and packed with fiber.',
    difficulty: 'Beginner',
    time: '2 hours',
    servings: '1 loaf',
    tags: ['whole wheat', 'healthy', 'quick'],
  ),
  Recipe(
    id: 5,
    title: 'Rye & Caraway',
    description:
        'Traditional European-style rye bread with distinctive caraway seeds. Rich, dense crumb perfect for sandwiches.',
    difficulty: 'Intermediate',
    time: '20 hours',
    servings: '1 loaf',
    tags: ['rye', 'european', 'savory'],
  ),
  Recipe(
    id: 6,
    title: 'Multigrain Harvest',
    description:
        'Hearty blend of oats, millet, flax, and sunflower seeds. A complete meal with high nutritional value.',
    difficulty: 'Intermediate',
    time: '3 hours',
    servings: '2 loaves',
    tags: ['multigrain', 'seeds', 'healthy'],
  ),
];
