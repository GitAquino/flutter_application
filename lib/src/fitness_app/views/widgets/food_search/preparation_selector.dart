import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';
import '../../../models/food_item.dart';

class PreparationSelector extends StatefulWidget {
  final PreparationType selectedPreparation;
  final Function(PreparationType) onPreparationSelected;
  final AnimationController? animationController;

  const PreparationSelector({
    super.key,
    required this.selectedPreparation,
    required this.onPreparationSelected,
    this.animationController,
  });

  @override
  _PreparationSelectorState createState() => _PreparationSelectorState();
}

class _PreparationSelectorState extends State<PreparationSelector>
    with TickerProviderStateMixin {
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0.3, 0.9, curve: Curves.fastOutSlowIn),
      ),
    );
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
                        'Tipo de Preparo',
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: FitnessAppTheme.darkText,
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: PreparationTypeData.preparations.length,
                          itemBuilder: (context, index) {
                            final preparation = PreparationTypeData.preparations[index];
                            final isSelected =
                                widget.selectedPreparation == preparation.type;
                            
                            return GestureDetector(
                              onTap: () {
                                widget.onPreparationSelected(preparation.type);
                              },
                              child: Container(
                                width: 70,
                                margin: EdgeInsets.only(
                                    right: index < PreparationTypeData.preparations.length - 1 ? 12 : 0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? FitnessAppTheme.nearlyDarkBlue
                                            : FitnessAppTheme.nearlyDarkBlue
                                                .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(25),
                                        border: isSelected
                                            ? Border.all(
                                                color: FitnessAppTheme.nearlyDarkBlue,
                                                width: 2)
                                            : Border.all(
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.3),
                                                width: 1),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          _getPreparationIcon(preparation.type),
                                          color: isSelected
                                              ? FitnessAppTheme.white
                                              : FitnessAppTheme.nearlyDarkBlue,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      preparation.name,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isSelected
                                            ? FitnessAppTheme.nearlyDarkBlue
                                            : FitnessAppTheme.grey,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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

  IconData _getPreparationIcon(PreparationType type) {
    switch (type) {
      case PreparationType.raw:
        return Icons.eco_outlined;
      case PreparationType.boiled:
        return Icons.water_drop;
      case PreparationType.fried:
        return Icons.local_fire_department;
      case PreparationType.baked:
        return Icons.local_fire_department;
      case PreparationType.grilled:
        return Icons.outdoor_grill;
      case PreparationType.steamed:
        return Icons.cloud;
      default:
        return Icons.restaurant;
    }
  }
}