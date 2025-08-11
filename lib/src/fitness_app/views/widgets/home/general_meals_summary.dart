import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';

class GeneralMealsSummary extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const GeneralMealsSummary({Key? key, this.animationController, this.animation})
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
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.analytics,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Resumo Geral',
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
                                  'Estatísticas dos últimos 7 dias',
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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: FitnessAppTheme.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '85%',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                ],
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
                            child: _buildStatCard(
                              'Média Diária',
                              '1.850',
                              'kcal',
                              Icons.local_fire_department,
                              Colors.orange,
                              '+120 kcal vs semana anterior',
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              'Refeições',
                              '28',
                              'completas',
                              Icons.check_circle,
                              Colors.green,
                              '4 refeições/dia em média',
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
                            child: _buildStatCard(
                              'Proteína',
                              '68g',
                              'média',
                              Icons.fitness_center,
                              Colors.red,
                              'Meta atingida 6/7 dias',
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              'Hidratação',
                              '2.1L',
                              'média',
                              Icons.water_drop,
                              Colors.blue,
                              'Meta atingida 5/7 dias',
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
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.withOpacity(0.1),
                              Colors.blue.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.green.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.emoji_events,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Conquistas da Semana',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: FitnessAppTheme.nearlyDarkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                _buildAchievementBadge('🥗', '5 dias seguidos'),
                                SizedBox(width: 8),
                                _buildAchievementBadge('💧', 'Meta de água'),
                                SizedBox(width: 8),
                                _buildAchievementBadge('🏆', 'Sem pular refeições'),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildStatCard(
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
    String subtitle,
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
                value,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
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
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.normal,
              fontSize: 9,
              color: FitnessAppTheme.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(String emoji, String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: FitnessAppTheme.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 2),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 8,
                color: FitnessAppTheme.nearlyDarkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}