class FoodItemModel {
  final String id;
  final String name;
  final double weight; // em gramas
  final String preparationType; // Ex: "Cru", "Cozido", "Grelhado", "Assado", etc.
  final double calories; // por porção
  final double protein; // em gramas
  final double carbs; // em gramas
  final double fat; // em gramas
  final double? fiber; // em gramas (opcional)
  final double? sodium; // em mg (opcional)
  final double? sugar; // em gramas (opcional)
  final DateTime? addedAt;

  FoodItemModel({
    String? id,
    required this.name,
    required this.weight,
    required this.preparationType,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.fiber,
    this.sodium,
    this.sugar,
    DateTime? addedAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
       addedAt = addedAt ?? DateTime.now();

  // Getters para valores nutricionais por 100g
  double get caloriesPer100g {
    return (calories / weight) * 100;
  }

  double get proteinPer100g {
    return (protein / weight) * 100;
  }

  double get carbsPer100g {
    return (carbs / weight) * 100;
  }

  double get fatPer100g {
    return (fat / weight) * 100;
  }

  // Método para calcular valores nutricionais para um peso específico
  Map<String, double> getNutritionForWeight(double targetWeight) {
    double ratio = targetWeight / weight;
    return {
      'calories': calories * ratio,
      'protein': protein * ratio,
      'carbs': carbs * ratio,
      'fat': fat * ratio,
      'fiber': (fiber ?? 0) * ratio,
      'sodium': (sodium ?? 0) * ratio,
      'sugar': (sugar ?? 0) * ratio,
    };
  }

  // Lista de tipos de preparo disponíveis
  static List<String> get preparationTypes => [
    'In natura',
    'Cru',
    'Cozido',
    'Grelhado',
    'Assado',
    'Frito',
    'Refogado',
    'Vapor',
    'Ensopado',
    'Marinado',
    'Defumado',
    'Outros',
  ];

  // Método para clonar com modificações
  FoodItemModel copyWith({
    String? id,
    String? name,
    double? weight,
    String? preparationType,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
    double? sodium,
    double? sugar,
    DateTime? addedAt,
  }) {
    return FoodItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      preparationType: preparationType ?? this.preparationType,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sodium: sodium ?? this.sodium,
      sugar: sugar ?? this.sugar,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'preparationType': preparationType,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'sodium': sodium,
      'sugar': sugar,
      'addedAt': addedAt?.toIso8601String(),
    };
  }

  // Criação a partir de JSON
  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'],
      name: json['name'],
      weight: json['weight'].toDouble(),
      preparationType: json['preparationType'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      carbs: json['carbs'].toDouble(),
      fat: json['fat'].toDouble(),
      fiber: json['fiber']?.toDouble(),
      sodium: json['sodium']?.toDouble(),
      sugar: json['sugar']?.toDouble(),
      addedAt: json['addedAt'] != null 
          ? DateTime.parse(json['addedAt']) 
          : null,
    );
  }

  @override
  String toString() {
    return 'FoodItemModel(name: $name, weight: ${weight}g, prep: $preparationType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FoodItemModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // Dados de exemplo para alimentos comuns
  static List<FoodItemModel> get sampleFoods => [
    FoodItemModel(
      name: 'Arroz Branco',
      weight: 100,
      preparationType: 'Cozido',
      calories: 130,
      protein: 2.7,
      carbs: 28.0,
      fat: 0.3,
      fiber: 0.4,
    ),
    FoodItemModel(
      name: 'Feijão Preto',
      weight: 100,
      preparationType: 'Cozido',
      calories: 132,
      protein: 8.9,
      carbs: 23.0,
      fat: 0.5,
      fiber: 8.7,
    ),
    FoodItemModel(
      name: 'Peito de Frango',
      weight: 100,
      preparationType: 'Grelhado',
      calories: 165,
      protein: 31.0,
      carbs: 0,
      fat: 3.6,
    ),
    FoodItemModel(
      name: 'Brócolis',
      weight: 100,
      preparationType: 'Cozido',
      calories: 34,
      protein: 2.8,
      carbs: 7.0,
      fat: 0.4,
      fiber: 2.6,
    ),
    FoodItemModel(
      name: 'Banana',
      weight: 100,
      preparationType: 'In natura',
      calories: 89,
      protein: 1.1,
      carbs: 22.8,
      fat: 0.3,
      fiber: 2.6,
      sugar: 12.2,
    ),
  ];
}