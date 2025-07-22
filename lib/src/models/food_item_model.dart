// lib/src/models/food_item_model.dart

class FoodItem {
  final String id;
  final String name;
  final String categoryId;
  final double correctionFactor; // Ex: 100g de arroz cru -> 250g cozido, fator = 2.5

  FoodItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.correctionFactor,
  });
}
