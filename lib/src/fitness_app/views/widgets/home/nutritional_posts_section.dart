import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';

class NutritionalPostsSection extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const NutritionalPostsSection({Key? key, this.animationController, this.animation})
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
                              color: Colors.teal.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.article,
                              color: Colors.teal,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Posts Nutricionais',
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
                                  'Conteúdo educativo e informativo',
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
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                'Novo',
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
                    _buildPostCard(
                      '🥑 Benefícios do Abacate',
                      'Rico em gorduras boas e fibras, o abacate é um excelente aliado para a saúde cardiovascular e controle do colesterol.',
                      '5 min de leitura',
                      Colors.green,
                      Icons.favorite,
                      '2.1k curtidas',
                    ),
                    _buildPostCard(
                      '🐟 Ômega-3: Por que é essencial?',
                      'Descubra os benefícios dos ácidos graxos ômega-3 para o cérebro, coração e sistema imunológico.',
                      '7 min de leitura',
                      Colors.blue,
                      Icons.psychology,
                      '1.8k curtidas',
                    ),
                    _buildPostCard(
                      '🌾 Carboidratos: Vilão ou Mocinho?',
                      'Entenda a diferença entre carboidratos simples e complexos e como incluí-los de forma saudável na sua dieta.',
                      '6 min de leitura',
                      Colors.orange,
                      Icons.grain,
                      '3.2k curtidas',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.withOpacity(0.1),
                              Colors.blue.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.teal.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_books,
                              color: Colors.teal,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Ver Todos os Posts',
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.teal,
                              ),
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

  Widget _buildPostCard(
    String title,
    String description,
    String readTime,
    Color accentColor,
    IconData icon,
    String likes,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: accentColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: accentColor,
                    size: 16,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: FitnessAppTheme.nearlyDarkBlue,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: FitnessAppTheme.grey,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            readTime,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: FitnessAppTheme.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: accentColor,
                        size: 10,
                      ),
                      SizedBox(width: 2),
                      Text(
                        likes,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.visibility,
                          color: accentColor,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Ler Mais',
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.nearlyWhite,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.bookmark_border,
                    color: FitnessAppTheme.grey,
                    size: 12,
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.nearlyWhite,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.share,
                    color: FitnessAppTheme.grey,
                    size: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}