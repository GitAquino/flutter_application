// lib/src/data/repositories/food_repository.dart

import '../../models/food_category_model.dart';
import '../../models/food_item_model.dart';

class FoodRepository {
  // Simula uma busca de dados em uma API ou DB
  final List<FoodCategory> _categories = [
    FoodCategory(id: 'c1', name: 'Grãos'),
    FoodCategory(id: 'c2', name: 'Carnes'),
    FoodCategory(id: 'c3', name: 'Frutas'),
    FoodCategory(id: 'c4', name: 'Vegetais'),
  ];

  final List<FoodItem> _items = [
    // Grãos
    FoodItem(id: 'i1', name: 'Arroz Branco', categoryId: 'c1', correctionFactor: 2.5),
    FoodItem(id: 'i2', name: 'Feijão Carioca', categoryId: 'c1', correctionFactor: 2.0),
    FoodItem(id: 'i3', name: 'Lentilha', categoryId: 'c1', correctionFactor: 2.2),
    // Carnes
    FoodItem(id: 'i4', name: 'Peito de Frango', categoryId: 'c2', correctionFactor: 0.75),
    FoodItem(id: 'i5', name: 'Patinho Moído', categoryId: 'c2', correctionFactor: 0.70),
    // Frutas
    FoodItem(id: 'i6', name: 'Banana', categoryId: 'c3', correctionFactor: 1.0),
    FoodItem(id: 'i7', name: 'Maçã', categoryId: 'c3', correctionFactor: 1.0),
  ];

  // Retorna todas as categorias
  Future<List<FoodCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simula latência de rede
    return _categories;
  }

  // Retorna os alimentos de uma categoria específica
  Future<List<FoodItem>> getFoodItemsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _items.where((item) => item.categoryId == categoryId).toList();
  }
}
