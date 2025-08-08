class FoodItem {
  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.nutritionalInfo,
    this.description = '',
    this.imagePath = '',
  });

  final String id;
  final String name;
  final FoodCategory category;
  final String description;
  final String imagePath;
  final NutritionalInfo nutritionalInfo;

  // Fatores de correção e cocção por categoria
  static const Map<FoodCategory, double> correctionFactors = {
    FoodCategory.meat: 1.0,
    FoodCategory.vegetable: 0.9,
    FoodCategory.fruit: 0.95,
    FoodCategory.grain: 0.85,
    FoodCategory.dairy: 1.0,
    FoodCategory.legume: 0.8,
    FoodCategory.nut: 1.0,
    FoodCategory.seafood: 1.0,
  };

  static const Map<PreparationType, double> cookingFactors = {
    PreparationType.raw: 1.0,
    PreparationType.boiled: 0.8,
    PreparationType.fried: 1.2,
    PreparationType.baked: 0.9,
    PreparationType.grilled: 0.85,
    PreparationType.steamed: 0.9,
  };

  double getCorrectionFactor() {
    return correctionFactors[category] ?? 1.0;
  }

  double getCookingFactor(PreparationType preparationType) {
    return cookingFactors[preparationType] ?? 1.0;
  }

  double calculateFinalWeight(double rawWeight, PreparationType preparationType) {
    final correctedWeight = rawWeight * getCorrectionFactor();
    final finalWeight = correctedWeight * getCookingFactor(preparationType);
    return finalWeight;
  }

  NutritionalInfo calculateNutrition(double finalWeight) {
    final factor = finalWeight / 100; // Base nutritional info is per 100g
    return NutritionalInfo(
      calories: nutritionalInfo.calories * factor,
      protein: nutritionalInfo.protein * factor,
      carbs: nutritionalInfo.carbs * factor,
      fat: nutritionalInfo.fat * factor,
      fiber: nutritionalInfo.fiber * factor,
    );
  }
}

class NutritionalInfo {
  NutritionalInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
}

enum FoodCategory {
  meat,
  vegetable,
  fruit,
  grain,
  dairy,
  legume,
  nut,
  seafood,
}

enum PreparationType {
  raw,
  boiled,
  fried,
  baked,
  grilled,
  steamed,
}

class FoodCategoryData {
  FoodCategoryData({
    required this.category,
    required this.name,
    required this.iconPath,
    required this.color,
  });

  final FoodCategory category;
  final String name;
  final String iconPath;
  final String color;

  static List<FoodCategoryData> categories = [
    FoodCategoryData(
      category: FoodCategory.meat,
      name: 'Carnes',
      iconPath: 'assets/fitness_app/meat_icon.png',
      color: '#FF6B6B',
    ),
    FoodCategoryData(
      category: FoodCategory.vegetable,
      name: 'Vegetais',
      iconPath: 'assets/fitness_app/vegetable_icon.png',
      color: '#4ECDC4',
    ),
    FoodCategoryData(
      category: FoodCategory.fruit,
      name: 'Frutas',
      iconPath: 'assets/fitness_app/fruit_icon.png',
      color: '#45B7D1',
    ),
    FoodCategoryData(
      category: FoodCategory.grain,
      name: 'Grãos',
      iconPath: 'assets/fitness_app/grain_icon.png',
      color: '#F9CA24',
    ),
    FoodCategoryData(
      category: FoodCategory.dairy,
      name: 'Laticínios',
      iconPath: 'assets/fitness_app/dairy_icon.png',
      color: '#F0932B',
    ),
    FoodCategoryData(
      category: FoodCategory.legume,
      name: 'Leguminosas',
      iconPath: 'assets/fitness_app/legume_icon.png',
      color: '#6C5CE7',
    ),
    FoodCategoryData(
      category: FoodCategory.nut,
      name: 'Oleaginosas',
      iconPath: 'assets/fitness_app/nut_icon.png',
      color: '#A29BFE',
    ),
    FoodCategoryData(
      category: FoodCategory.seafood,
      name: 'Frutos do Mar',
      iconPath: 'assets/fitness_app/seafood_icon.png',
      color: '#74B9FF',
    ),
  ];
}

class PreparationTypeData {
  PreparationTypeData({
    required this.type,
    required this.name,
    required this.iconPath,
  });

  final PreparationType type;
  final String name;
  final String iconPath;

  static List<PreparationTypeData> preparations = [
    PreparationTypeData(
      type: PreparationType.raw,
      name: 'Cru',
      iconPath: 'assets/fitness_app/raw_icon.png',
    ),
    PreparationTypeData(
      type: PreparationType.boiled,
      name: 'Cozido',
      iconPath: 'assets/fitness_app/boiled_icon.png',
    ),
    PreparationTypeData(
      type: PreparationType.fried,
      name: 'Frito',
      iconPath: 'assets/fitness_app/fried_icon.png',
    ),
    PreparationTypeData(
      type: PreparationType.baked,
      name: 'Assado',
      iconPath: 'assets/fitness_app/baked_icon.png',
    ),
    PreparationTypeData(
      type: PreparationType.grilled,
      name: 'Grelhado',
      iconPath: 'assets/fitness_app/grilled_icon.png',
    ),
    PreparationTypeData(
      type: PreparationType.steamed,
      name: 'No Vapor',
      iconPath: 'assets/fitness_app/steamed_icon.png',
    ),
  ];
}