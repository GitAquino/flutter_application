import 'food_item_model.dart';

class MealListModel {
  final String id;
  final String name;
  final String description;
  final List<FoodItemModel> foodItems;
  final DateTime createdAt;
  final DateTime? updatedAt;

  MealListModel({
    required this.id,
    required this.name,
    required this.description,
    required this.foodItems,
    required this.createdAt,
    this.updatedAt,
  });

  // Getters para cálculos nutricionais
  double get totalCalories {
    return foodItems.fold(0.0, (sum, item) => sum + item.calories);
  }

  double get totalProtein {
    return foodItems.fold(0.0, (sum, item) => sum + item.protein);
  }

  double get totalCarbs {
    return foodItems.fold(0.0, (sum, item) => sum + item.carbs);
  }

  double get totalFat {
    return foodItems.fold(0.0, (sum, item) => sum + item.fat);
  }

  double get totalWeight {
    return foodItems.fold(0.0, (sum, item) => sum + item.weight);
  }

  // Método para obter ingredientes sem preparo
  Map<String, double> get rawIngredients {
    Map<String, double> ingredients = {};
    
    for (var item in foodItems) {
      String key = '${item.name} (${item.preparationType})';
      if (ingredients.containsKey(key)) {
        ingredients[key] = ingredients[key]! + item.weight;
      } else {
        ingredients[key] = item.weight;
      }
    }
    
    return ingredients;
  }

  // Método para clonar com modificações
  MealListModel copyWith({
    String? id,
    String? name,
    String? description,
    List<FoodItemModel>? foodItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      foodItems: foodItems ?? this.foodItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'foodItems': foodItems.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Criação a partir de JSON
  factory MealListModel.fromJson(Map<String, dynamic> json) {
    return MealListModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      foodItems: (json['foodItems'] as List)
          .map((item) => FoodItemModel.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  @override
  String toString() {
    return 'MealListModel(id: $id, name: $name, foodItems: ${foodItems.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MealListModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}