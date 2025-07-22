// lib/src/ui/controllers/food_controller.dart

import 'package:flutter/material.dart';
import '../../data/repositories/food_repository.dart';
import '../../models/food_category_model.dart';
import '../../models/food_item_model.dart';

class FoodController extends ChangeNotifier {
  final FoodRepository _repository = FoodRepository();

  // Estado da UI
  List<FoodCategory> categories = [];
  List<FoodItem> foodItems = [];
  bool isLoading = false;
  
  // Seleções do usuário
  FoodCategory? selectedCategory;
  FoodItem? selectedFoodItem;
  final TextEditingController weightController = TextEditingController();

  // Resultado do cálculo
  double? calculatedWeight;

  FoodController() {
    fetchCategories();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _setLoading(true);
    categories = await _repository.getCategories();
    _setLoading(false);
  }

  Future<void> onCategorySelected(FoodCategory? category) async {
    if (category == null || category == selectedCategory) return;
    
    selectedCategory = category;
    // Limpa seleções anteriores
    selectedFoodItem = null;
    foodItems = [];
    weightController.clear();
    calculatedWeight = null;

    _setLoading(true);
    foodItems = await _repository.getFoodItemsByCategory(category.id);
    _setLoading(false);
  }

  void onFoodItemSelected(FoodItem? food) {
    if (food == null || food == selectedFoodItem) return;
    
    selectedFoodItem = food;
    weightController.clear();
    calculatedWeight = null;
    notifyListeners();
  }

  void calculateWeight() {
    final rawWeight = double.tryParse(weightController.text);
    if (rawWeight != null && selectedFoodItem != null) {
      calculatedWeight = rawWeight * selectedFoodItem!.correctionFactor;
    } else {
      calculatedWeight = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
}
