import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';
import '../../../models/food_item.dart';

class FoodListView extends StatelessWidget {
  final List<FoodItem> foods;
  final Function(FoodItem) onFoodSelected;
  final AnimationController? animationController;

  const FoodListView({
    super.key,
    required this.foods,
    required this.onFoodSelected,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
                parent: animationController!,
                curve: Interval((1 / foods.length) * index, 1.0,
                    curve: Curves.fastOutSlowIn)));
        
        return AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: animation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 50 * (1.0 - animation.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 8, bottom: 16),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => onFoodSelected(food),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withValues(alpha: 0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 8, top: 16),
                                  child: Text(
                                    food.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.1,
                                        color: FitnessAppTheme.darkText),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${food.calories.toStringAsFixed(0)} kcal/100g',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: -0.1,
                                        color: FitnessAppTheme.grey
                                            .withValues(alpha: 0.5),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.nearlyDarkBlue,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.add,
                                          color: FitnessAppTheme.white,
                                          size: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 8, bottom: 16),
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: FitnessAppTheme.background,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 8, bottom: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Proteína',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                letterSpacing: -0.2,
                                                color: FitnessAppTheme.darkText,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4),
                                              child: Container(
                                                height: 4,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#87A0E5')
                                                      .withValues(alpha: 0.2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: ((70 / 100) *
                                                          food.protein),
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              HexColor('#87A0E5'),
                                                              HexColor('#87A0E5')
                                                                  .withValues(
                                                                      alpha: 0.5),
                                                            ]),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        4.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6),
                                              child: Text(
                                                '${food.protein.toStringAsFixed(1)}g',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: FitnessAppTheme.grey
                                                      .withValues(alpha: 0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Carboidratos',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    letterSpacing: -0.2,
                                                    color: FitnessAppTheme
                                                        .darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#F56E98')
                                                          .withValues(alpha: 0.2),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: ((70 / 100) *
                                                              food.carbs),
                                                          height: 4,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                              HexColor(
                                                                  '#F56E98'),
                                                              HexColor(
                                                                      '#F56E98')
                                                                  .withValues(
                                                                      alpha:
                                                                          0.5),
                                                            ]),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    '${food.carbs.toStringAsFixed(1)}g',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: FitnessAppTheme
                                                          .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: FitnessAppTheme
                                                          .grey
                                                          .withValues(
                                                              alpha: 0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Gordura',
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    letterSpacing: -0.2,
                                                    color: FitnessAppTheme
                                                        .darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#F1B440')
                                                          .withValues(alpha: 0.2),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: ((70 / 100) *
                                                              food.fat),
                                                          height: 4,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                              HexColor(
                                                                  '#F1B440'),
                                                              HexColor(
                                                                      '#F1B440')
                                                                  .withValues(
                                                                      alpha:
                                                                          0.5),
                                                            ]),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    '${food.fat.toStringAsFixed(1)}g',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: FitnessAppTheme
                                                          .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: FitnessAppTheme
                                                          .grey
                                                          .withValues(
                                                              alpha: 0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
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
      },
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}