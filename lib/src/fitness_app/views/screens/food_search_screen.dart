import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/fitness_app_theme.dart';
import '../../models/food_item.dart';
import '../../services/food_service.dart';
import '../widgets/food_search/category_selector.dart';
import '../widgets/food_search/preparation_selector.dart';
import '../widgets/food_search/food_list_view.dart';
import '../widgets/food_search/weight_calculator.dart';

class FoodSearchScreen extends StatefulWidget {
  final AnimationController? animationController;

  const FoodSearchScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final FoodService _foodService = FoodService();
  
  List<FoodItem> _searchResults = [];
  FoodItem? _selectedFood;
  FoodCategory? _selectedCategory;
  PreparationType _selectedPreparation = PreparationType.raw;
  double _rawWeight = 0.0;
  double _finalWeight = 0.0;
  bool _isLoading = false;
  
  AnimationController? _listAnimationController;
  Animation<double>? _topBarAnimation;
  double topBarOpacity = 0.0;
  
  @override
  void initState() {
    super.initState();
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    
    _loadInitialFoods();
    _searchController.addListener(_onSearchChanged);
    _weightController.addListener(_onWeightChanged);
  }

  @override
  void dispose() {
    _listAnimationController?.dispose();
    _searchController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _loadInitialFoods() async {
    setState(() => _isLoading = true);
    try {
      final foods = await _foodService.getAllFoods();
      setState(() {
        _searchResults = foods;
        _isLoading = false;
      });
      _listAnimationController?.forward();
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    _performSearch(query);
  }

  void _onWeightChanged() {
    final weightText = _weightController.text;
    if (weightText.isNotEmpty) {
      final weight = double.tryParse(weightText) ?? 0.0;
      setState(() {
        _rawWeight = weight;
        _calculateFinalWeight();
      });
    }
  }

  void _performSearch(String query) async {
    setState(() => _isLoading = true);
    try {
      List<FoodItem> results;
      if (_selectedCategory != null) {
        final categoryFoods = await _foodService.getFoodsByCategory(_selectedCategory!);
        results = categoryFoods
            .where((food) => food.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        results = await _foodService.searchFoodsByName(query);
      }
      
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _onCategorySelected(FoodCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
    _performSearch(_searchController.text);
  }

  void _onPreparationSelected(PreparationType preparation) {
    setState(() {
      _selectedPreparation = preparation;
      _calculateFinalWeight();
    });
  }

  void _onFoodSelected(FoodItem food) {
    setState(() {
      _selectedFood = food;
      _calculateFinalWeight();
    });
  }

  void _calculateFinalWeight() {
    if (_selectedFood != null && _rawWeight > 0) {
      final finalWeight = _selectedFood!.calculateFinalWeight(_rawWeight, _selectedPreparation);
      setState(() {
        _finalWeight = finalWeight;
      });
    } else {
      setState(() {
        _finalWeight = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView(
            children: <Widget>[
              SizedBox(
                height: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top + 24,
              ),
              // Campo de busca
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Container(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar alimento...',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: FitnessAppTheme.darkText,
                      ),
                    ),
                  ),
                ),
              ),
              // Seletor de categoria
              CategorySelector(
                selectedCategory: _selectedCategory,
                onCategorySelected: _onCategorySelected,
                animationController: _listAnimationController,
              ),
              // Seletor de preparo
              PreparationSelector(
                selectedPreparation: _selectedPreparation,
                onPreparationSelected: _onPreparationSelected,
                animationController: _listAnimationController,
              ),
              // Campo de peso
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Container(
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Peso do Alimento (g)',
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: FitnessAppTheme.darkText,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Digite o peso em gramas',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: FitnessAppTheme.grey.withOpacity(0.3),
                              ),
                            ),
                            suffixText: 'g',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Calculadora de peso
              if (_selectedFood != null && _rawWeight > 0)
                WeightCalculator(
                  selectedFood: _selectedFood!,
                  rawWeight: _rawWeight,
                  finalWeight: _finalWeight,
                  preparationType: _selectedPreparation,
                  animationController: _listAnimationController,
                ),
              // Lista de alimentos
              FoodListView(
                foods: _searchResults,
                selectedFood: _selectedFood,
                onFoodSelected: _onFoodSelected,
                isLoading: _isLoading,
                animationController: _listAnimationController,
              ),
              SizedBox(height: 100),
            ],
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: _topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - _topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Buscar Alimentos',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }
}