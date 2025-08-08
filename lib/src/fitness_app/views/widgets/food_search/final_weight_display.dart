import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';
import '../../../models/food_item.dart';

class FinalWeightDisplay extends StatefulWidget {
  final FoodItem? selectedFood;
  final PreparationType preparationType;
  final double inputWeight;
  final AnimationController? animationController;

  const FinalWeightDisplay({
    Key? key,
    required this.selectedFood,
    required this.preparationType,
    required this.inputWeight,
    this.animationController,
  }) : super(key: key);

  @override
  _FinalWeightDisplayState createState() => _FinalWeightDisplayState();
}

class _FinalWeightDisplayState extends State<FinalWeightDisplay>
    with TickerProviderStateMixin {
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  double get finalWeight {
    if (widget.selectedFood == null || widget.inputWeight <= 0) {
      return 0.0;
    }
    return widget.selectedFood!.calculateFinalWeight(
      widget.inputWeight,
      widget.preparationType,
    );
  }

  NutritionalInfo get finalNutrition {
    if (widget.selectedFood == null || widget.inputWeight <= 0) {
      return NutritionalInfo(
        calories: 0,
        protein: 0,
        carbs: 0,
        fat: 0,
        fiber: 0,
      );
    }
    return widget.selectedFood!.calculateNutrition(widget.inputWeight);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FitnessAppTheme.nearlyDarkBlue,
                      FitnessAppTheme.nearlyBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.6),
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
                      Row(
                        children: [
                          Icon(
                            Icons.calculate,
                            color: FitnessAppTheme.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Resultado Final',
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: FitnessAppTheme.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      if (widget.selectedFood != null && widget.inputWeight > 0) ...
                        _buildResultContent()
                      else
                        _buildEmptyState(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildResultContent() {
    return [
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: FitnessAppTheme.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Peso Final',
                  style: TextStyle(
                    fontSize: 12,
                    color: FitnessAppTheme.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  '${finalWeight.toStringAsFixed(1)}g',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: FitnessAppTheme.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Calorias',
                  style: TextStyle(
                    fontSize: 12,
                    color: FitnessAppTheme.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  '${finalNutrition.calories.toStringAsFixed(0)} kcal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: FitnessAppTheme.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildNutrientInfo(
              'Proteína',
              '${finalNutrition.protein.toStringAsFixed(1)}g',
              Icons.fitness_center,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildNutrientInfo(
              'Carboidratos',
              '${finalNutrition.carbs.toStringAsFixed(1)}g',
              Icons.grain,
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: _buildNutrientInfo(
              'Gordura',
              '${finalNutrition.fat.toStringAsFixed(1)}g',
              Icons.opacity,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildNutrientInfo(
              'Fibra',
              '${finalNutrition.fiber.toStringAsFixed(1)}g',
              Icons.eco,
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildNutrientInfo(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: FitnessAppTheme.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: FitnessAppTheme.white.withOpacity(0.8),
            size: 16,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: FitnessAppTheme.white.withOpacity(0.8),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: FitnessAppTheme.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            color: FitnessAppTheme.white.withOpacity(0.6),
            size: 48,
          ),
          SizedBox(height: 12),
          Text(
            'Selecione um alimento e informe o peso para ver o resultado',
            style: TextStyle(
              fontSize: 14,
              color: FitnessAppTheme.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}