import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/fitness_app_theme.dart';
import '../../../models/food_item.dart';

class WeightCalculator extends StatefulWidget {
  final FoodItem? selectedFood;
  final PreparationType preparationType;
  final Function(double rawWeight, double finalWeight) onWeightChanged;
  final AnimationController? animationController;

  const WeightCalculator({
    super.key,
    this.selectedFood,
    required this.preparationType,
    required this.onWeightChanged,
    this.animationController,
  });

  @override
  _WeightCalculatorState createState() => _WeightCalculatorState();
}

class _WeightCalculatorState extends State<WeightCalculator> {
  final TextEditingController _rawWeightController = TextEditingController();
  final TextEditingController _finalWeightController = TextEditingController();
  
  double _rawWeight = 0.0;
  double _finalWeight = 0.0;
  bool _isCalculatingFromRaw = true;

  @override
  void initState() {
    super.initState();
    _rawWeightController.addListener(_onRawWeightChanged);
    _finalWeightController.addListener(_onFinalWeightChanged);
  }

  @override
  void dispose() {
    _rawWeightController.dispose();
    _finalWeightController.dispose();
    super.dispose();
  }

  void _onRawWeightChanged() {
    if (_isCalculatingFromRaw) {
      final rawWeight = double.tryParse(_rawWeightController.text) ?? 0.0;
      setState(() {
        _rawWeight = rawWeight;
        _finalWeight = _calculateFinalWeight(rawWeight, widget.preparationType);
        _finalWeightController.text = _finalWeight.toStringAsFixed(1);
      });
      widget.onWeightChanged(_rawWeight, _finalWeight);
    }
  }

  void _onFinalWeightChanged() {
    if (!_isCalculatingFromRaw) {
      final finalWeight = double.tryParse(_finalWeightController.text) ?? 0.0;
      setState(() {
        _finalWeight = finalWeight;
        _rawWeight = _calculateRawWeight(finalWeight, widget.preparationType);
        _rawWeightController.text = _rawWeight.toStringAsFixed(1);
      });
      widget.onWeightChanged(_rawWeight, _finalWeight);
    }
  }

  double _calculateFinalWeight(double rawWeight, PreparationType preparation) {
    switch (preparation) {
      case PreparationType.raw:
        return rawWeight;
      case PreparationType.boiled:
        return rawWeight * 0.75; // Perda de 25% no cozimento
      case PreparationType.grilled:
        return rawWeight * 0.70; // Perda de 30% na grelha
      case PreparationType.fried:
        return rawWeight * 0.80; // Perda de 20% na fritura
      case PreparationType.steamed:
        return rawWeight * 0.85; // Perda de 15% no vapor
      case PreparationType.baked:
        return rawWeight * 0.75; // Perda de 25% no forno
      default:
        return rawWeight;
    }
  }

  double _calculateRawWeight(double finalWeight, PreparationType preparation) {
    switch (preparation) {
      case PreparationType.raw:
        return finalWeight;
      case PreparationType.boiled:
        return finalWeight / 0.75;
      case PreparationType.grilled:
        return finalWeight / 0.70;
      case PreparationType.fried:
        return finalWeight / 0.80;
      case PreparationType.steamed:
        return finalWeight / 0.85;
      case PreparationType.baked:
        return finalWeight / 0.75;
      default:
        return finalWeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedFood == null) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animationController!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animationController!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withValues(alpha: 0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Calculadora de Peso',
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: FitnessAppTheme.darkText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.selectedFood!.name,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: FitnessAppTheme.darkText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Peso Cru (g)',
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: FitnessAppTheme.grey.withValues(alpha: 0.8),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _rawWeightController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}')),
                                  ],
                                  onTap: () {
                                    setState(() {
                                      _isCalculatingFromRaw = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: FitnessAppTheme.grey.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: FitnessAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    hintText: '0.0',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Peso Final (g)',
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: FitnessAppTheme.grey.withValues(alpha: 0.8),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _finalWeightController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}')),
                                  ],
                                  onTap: () {
                                    setState(() {
                                      _isCalculatingFromRaw = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: FitnessAppTheme.grey.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: FitnessAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    hintText: '0.0',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_rawWeight > 0 && widget.selectedFood != null) ...
                        _buildNutritionalInfo(),
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

  List<Widget> _buildNutritionalInfo() {
    final food = widget.selectedFood!;
    final factor = _finalWeight / 100; // Fator para calcular com base no peso final
    
    return [
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: FitnessAppTheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações Nutricionais',
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: FitnessAppTheme.darkText,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calorias:',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontSize: 12,
                    color: FitnessAppTheme.grey.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '${(food.nutritionalInfo.calories * factor).toStringAsFixed(1)} kcal',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: FitnessAppTheme.darkText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Proteínas:',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontSize: 12,
                    color: FitnessAppTheme.grey.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '${(food.nutritionalInfo.protein * factor).toStringAsFixed(1)}g',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: FitnessAppTheme.darkText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Carboidratos:',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontSize: 12,
                    color: FitnessAppTheme.grey.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '${(food.nutritionalInfo.carbs * factor).toStringAsFixed(1)}g',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: FitnessAppTheme.darkText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gorduras:',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontSize: 12,
                    color: FitnessAppTheme.grey.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '${(food.nutritionalInfo.fat * factor).toStringAsFixed(1)}g',
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: FitnessAppTheme.darkText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}