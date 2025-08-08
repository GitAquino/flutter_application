import '../models/food_item.dart';

class FoodService {
  static final FoodService _instance = FoodService._internal();
  factory FoodService() => _instance;
  FoodService._internal();

  // Lista de alimentos de exemplo - futuramente será substituída pelo Firebase
  static final List<FoodItem> _sampleFoods = [
    // Carnes
    FoodItem(
      id: '1',
      name: 'Frango (peito)',
      category: FoodCategory.meat,
      description: 'Peito de frango sem pele',
      imagePath: 'assets/fitness_app/chicken.png',
      nutritionalInfo: NutritionalInfo(
        calories: 165,
        protein: 31,
        carbs: 0,
        fat: 3.6,
        fiber: 0,
      ),
    ),
    FoodItem(
      id: '2',
      name: 'Carne Bovina (alcatra)',
      category: FoodCategory.meat,
      description: 'Alcatra bovina magra',
      imagePath: 'assets/fitness_app/beef.png',
      nutritionalInfo: NutritionalInfo(
        calories: 250,
        protein: 26,
        carbs: 0,
        fat: 15,
        fiber: 0,
      ),
    ),
    // Vegetais
    FoodItem(
      id: '3',
      name: 'Brócolis',
      category: FoodCategory.vegetable,
      description: 'Brócolis fresco',
      imagePath: 'assets/fitness_app/broccoli.png',
      nutritionalInfo: NutritionalInfo(
        calories: 34,
        protein: 2.8,
        carbs: 7,
        fat: 0.4,
        fiber: 2.6,
      ),
    ),
    FoodItem(
      id: '4',
      name: 'Cenoura',
      category: FoodCategory.vegetable,
      description: 'Cenoura crua',
      imagePath: 'assets/fitness_app/carrot.png',
      nutritionalInfo: NutritionalInfo(
        calories: 41,
        protein: 0.9,
        carbs: 10,
        fat: 0.2,
        fiber: 2.8,
      ),
    ),
    // Frutas
    FoodItem(
      id: '5',
      name: 'Maçã',
      category: FoodCategory.fruit,
      description: 'Maçã vermelha com casca',
      imagePath: 'assets/fitness_app/apple.png',
      nutritionalInfo: NutritionalInfo(
        calories: 52,
        protein: 0.3,
        carbs: 14,
        fat: 0.2,
        fiber: 2.4,
      ),
    ),
    FoodItem(
      id: '6',
      name: 'Banana',
      category: FoodCategory.fruit,
      description: 'Banana nanica madura',
      imagePath: 'assets/fitness_app/banana.png',
      nutritionalInfo: NutritionalInfo(
        calories: 89,
        protein: 1.1,
        carbs: 23,
        fat: 0.3,
        fiber: 2.6,
      ),
    ),
    // Grãos
    FoodItem(
      id: '7',
      name: 'Arroz Integral',
      category: FoodCategory.grain,
      description: 'Arroz integral cozido',
      imagePath: 'assets/fitness_app/brown_rice.png',
      nutritionalInfo: NutritionalInfo(
        calories: 111,
        protein: 2.6,
        carbs: 23,
        fat: 0.9,
        fiber: 1.8,
      ),
    ),
    FoodItem(
      id: '8',
      name: 'Aveia',
      category: FoodCategory.grain,
      description: 'Aveia em flocos',
      imagePath: 'assets/fitness_app/oats.png',
      nutritionalInfo: NutritionalInfo(
        calories: 389,
        protein: 16.9,
        carbs: 66,
        fat: 6.9,
        fiber: 10.6,
      ),
    ),
    // Laticínios
    FoodItem(
      id: '9',
      name: 'Leite Desnatado',
      category: FoodCategory.dairy,
      description: 'Leite de vaca desnatado',
      imagePath: 'assets/fitness_app/milk.png',
      nutritionalInfo: NutritionalInfo(
        calories: 34,
        protein: 3.4,
        carbs: 5,
        fat: 0.2,
        fiber: 0,
      ),
    ),
    // Leguminosas
    FoodItem(
      id: '10',
      name: 'Feijão Preto',
      category: FoodCategory.legume,
      description: 'Feijão preto cozido',
      imagePath: 'assets/fitness_app/black_beans.png',
      nutritionalInfo: NutritionalInfo(
        calories: 132,
        protein: 8.9,
        carbs: 24,
        fat: 0.5,
        fiber: 8.7,
      ),
    ),
  ];

  // Buscar alimentos por nome
  Future<List<FoodItem>> searchFoodsByName(String query) async {
    // Simula delay de rede - remover quando integrar com Firebase
    await Future.delayed(Duration(milliseconds: 300));
    
    if (query.isEmpty) {
      return _sampleFoods;
    }
    
    return _sampleFoods
        .where((food) => food.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Buscar alimentos por categoria
  Future<List<FoodItem>> getFoodsByCategory(FoodCategory category) async {
    await Future.delayed(Duration(milliseconds: 200));
    
    return _sampleFoods
        .where((food) => food.category == category)
        .toList();
  }

  // Obter todos os alimentos
  Future<List<FoodItem>> getAllFoods() async {
    await Future.delayed(Duration(milliseconds: 200));
    return _sampleFoods;
  }

  // Obter alimento por ID
  Future<FoodItem?> getFoodById(String id) async {
    await Future.delayed(Duration(milliseconds: 100));
    
    try {
      return _sampleFoods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }

  // Métodos para futura integração com Firebase
  Future<void> addFood(FoodItem food) async {
    // TODO: Implementar adição no Firebase
    _sampleFoods.add(food);
  }

  Future<void> updateFood(FoodItem food) async {
    // TODO: Implementar atualização no Firebase
    final index = _sampleFoods.indexWhere((f) => f.id == food.id);
    if (index != -1) {
      _sampleFoods[index] = food;
    }
  }

  Future<void> deleteFood(String id) async {
    // TODO: Implementar remoção no Firebase
    _sampleFoods.removeWhere((food) => food.id == id);
  }
}