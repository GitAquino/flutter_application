import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/fitness_app_theme.dart';

class WeightInput extends StatefulWidget {
  final double weight;
  final Function(double) onWeightChanged;
  final AnimationController? animationController;

  const WeightInput({
    super.key,
    required this.weight,
    required this.onWeightChanged,
    this.animationController,
  });

  @override
  _WeightInputState createState() => _WeightInputState();
}

class _WeightInputState extends State<WeightInput>
    with TickerProviderStateMixin {
  Animation<double>? animation;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _controller = TextEditingController(
      text: widget.weight > 0 ? widget.weight.toString() : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: FitnessAppTheme.nearlyWhite,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: FitnessAppTheme.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Digite o peso...',
                                  hintStyle: TextStyle(
                                    color: FitnessAppTheme.grey,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: FitnessAppTheme.darkText,
                                ),
                                onChanged: (value) {
                                  final weight = double.tryParse(value) ?? 0.0;
                                  widget.onWeightChanged(weight);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.nearlyDarkBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.scale,
                                color: FitnessAppTheme.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Insira o peso em gramas do alimento antes do preparo',
                        style: TextStyle(
                          fontSize: 12,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
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
}