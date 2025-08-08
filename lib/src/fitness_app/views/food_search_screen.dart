import 'package:flutter/material.dart';
import '../config/fitness_app_theme.dart';
import '../models/food_item.dart';
import '../services/food_service.dart';
import 'widgets/food_search/category_selector.dart';
import 'widgets/food_search/preparation_selector.dart';
import 'widgets/food_search/weight_input.dart';
import 'widgets/food_search/final_weight_display.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({Key? key, this.animationController}) : super(key: key);
  
  final AnimationController? animationController;

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen>
    with TickerProviderStateMixin {
  final FoodService _foodService = FoodService();
  
  // Estado da tela
  String _searchQuery = '';
  FoodCategory? _selectedCategory;
  PreparationType _selectedPreparation = PreparationType.raw;
  double _inputWeight = 0.0;
  FoodItem? _selectedFood;
  List<FoodItem> _searchResults = [];
  bool _showResults = false;

  @override
  void initState() {
    widget.animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _performSearch() async {
    if (_searchQuery.isNotEmpty) {
      final results = await _foodService.searchFoodsByName(_searchQuery);
      setState(() {
        _searchResults = results;
        _showResults = true;
      });
    } else {
      setState(() {
        _searchResults = [];
        _showResults = false;
      });
    }
  }

  void _filterByCategory() async {
    if (_selectedCategory != null) {
      final results = await _foodService.getFoodsByCategory(_selectedCategory!);
      setState(() {
        _searchResults = results;
        _showResults = true;
      });
    } else {
      final results = await _foodService.getAllFoods();
      setState(() {
        _searchResults = results;
        _showResults = true;
      });
    }
  }

  void _selectFood(FoodItem food) {
    setState(() {
      _selectedFood = food;
      _showResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getSearchBarUI(),
                    if (_showResults) getSearchResults(),
                    if (_selectedFood != null) getSelectedFoodInfo(),
                    CategorySelector(
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                        _filterByCategory();
                      },
                      animationController: widget.animationController,
                    ),
                    PreparationSelector(
                      selectedPreparation: _selectedPreparation,
                      onPreparationSelected: (preparation) {
                        setState(() {
                          _selectedPreparation = preparation;
                        });
                      },
                      animationController: widget.animationController,
                    ),
                    WeightInput(
                      weight: _inputWeight,
                      onWeightChanged: (weight) {
                        setState(() {
                          _inputWeight = weight;
                        });
                      },
                      animationController: widget.animationController,
                    ),
                    FinalWeightDisplay(
                      selectedFood: _selectedFood,
                      preparationType: _selectedPreparation,
                      inputWeight: _inputWeight,
                      animationController: widget.animationController,
                    ),
                    SizedBox(height: 100), // Espaço extra no final
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 18,
        right: 18,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Buscar Alimentos',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: FitnessAppTheme.lightText,
                  ),
                ),
                Text(
                  'Encontre e calcule',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: FitnessAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FitnessAppTheme.nearlyBlue.withOpacity(0.1),
            ),
            child: Icon(
              Icons.person,
              size: 30,
              color: FitnessAppTheme.nearlyBlue,
            ),
          )
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {
                      setState(() {
                        _searchQuery = txt;
                      });
                      _performSearch();
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: FitnessAppTheme.nearlyDarkBlue,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar alimento...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _performSearch();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: FitnessAppTheme.nearlyWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchResults() {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
      decoration: BoxDecoration(
        color: FitnessAppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: FitnessAppTheme.grey.withOpacity(0.4),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resultados da Busca',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: FitnessAppTheme.darkText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showResults = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: FitnessAppTheme.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: _searchResults.isEmpty
                ? Center(
                    child: Text(
                      'Nenhum alimento encontrado',
                      style: TextStyle(
                        color: FitnessAppTheme.grey,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final food = _searchResults[index];
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            _getCategoryIcon(food.category),
                            color: FitnessAppTheme.nearlyDarkBlue,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          food.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          '${food.nutritionalInfo.calories.toStringAsFixed(0)} kcal/100g',
                          style: TextStyle(
                            fontSize: 12,
                            color: FitnessAppTheme.grey,
                          ),
                        ),
                        onTap: () => _selectFood(food),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedFoodInfo() {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
      decoration: BoxDecoration(
        color: FitnessAppTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: FitnessAppTheme.grey.withOpacity(0.4),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyDarkBlue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getCategoryIcon(_selectedFood!.category),
                color: FitnessAppTheme.white,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedFood!.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: FitnessAppTheme.darkText,
                    ),
                  ),
                  Text(
                    'Categoria: ${_getCategoryName(_selectedFood!.category)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: FitnessAppTheme.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFood = null;
                });
              },
              child: Icon(
                Icons.close,
                color: FitnessAppTheme.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(FoodCategory category) {
    switch (category) {
      case FoodCategory.meat:
        return Icons.set_meal;
      case FoodCategory.vegetable:
        return Icons.eco;
      case FoodCategory.fruit:
        return Icons.apple;
      case FoodCategory.grain:
        return Icons.grain;
      case FoodCategory.dairy:
        return Icons.local_drink;
      case FoodCategory.legume:
        return Icons.spa;
      default:
        return Icons.restaurant;
    }
  }

  String _getCategoryName(FoodCategory category) {
    switch (category) {
      case FoodCategory.meat:
        return 'Carne';
      case FoodCategory.vegetable:
        return 'Vegetal';
      case FoodCategory.fruit:
        return 'Fruta';
      case FoodCategory.grain:
        return 'Grão';
      case FoodCategory.dairy:
        return 'Laticínio';
      case FoodCategory.legume:
        return 'Leguminosa';
      default:
        return 'Outros';
    }
  }
}