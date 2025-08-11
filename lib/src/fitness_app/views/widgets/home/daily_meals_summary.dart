import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';

class DailyMealsSummary extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const DailyMealsSummary({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 12),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.restaurant,
                              color: FitnessAppTheme.nearlyDarkBlue,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Resumo Diário',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    color: FitnessAppTheme.nearlyDarkBlue,
                                  ),
                                ),
                                Text(
                                  'Suas refeições de hoje',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    letterSpacing: 0.0,
                                    color: FitnessAppTheme.grey.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.nearlyDarkBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                '3/5',
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: _buildNutrientCard(
                              'Calorias',
                              '1.247',
                              '2.000',
                              'kcal',
                              Icons.local_fire_department,
                              Colors.orange,
                              0.62,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildNutrientCard(
                              'Proteínas',
                              '45',
                              '80',
                              'g',
                              Icons.fitness_center,
                              Colors.red,
                              0.56,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: _buildNutrientCard(
                              'Carboidratos',
                              '156',
                              '250',
                              'g',
                              Icons.grain,
                              Colors.blue,
                              0.62,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildNutrientCard(
                              'Gorduras',
                              '28',
                              '67',
                              'g',
                              Icons.opacity,
                              Colors.green,
                              0.42,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.nearlyWhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.schedule,
                              color: FitnessAppTheme.nearlyDarkBlue,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Próxima refeição: Lanche da tarde (15:30)',
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: FitnessAppTheme.nearlyDarkBlue,
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNutrientCard(
    String title,
    String current,
    String target,
    String unit,
    IconData icon,
    Color color,
    double progress,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: FitnessAppTheme.nearlyDarkBlue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                current,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
              Text(
                '/$target',
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: FitnessAppTheme.grey,
                ),
              ),
              SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: FitnessAppTheme.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}