import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';

class NutritionistTipsSection extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const NutritionistTipsSection({Key? key, this.animationController, this.animation})
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
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.withOpacity(0.1),
                      Colors.purple.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink,
                                  Colors.purple,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.3),
                                  offset: Offset(0, 2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.psychology,
                              color: FitnessAppTheme.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Dicas da Nutri 👩‍⚕️',
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
                                  'Dra. Maria Silva - CRN 12345',
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
                              gradient: LinearGradient(
                                colors: [Colors.pink, Colors.purple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: FitnessAppTheme.white,
                                    size: 12,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Premium',
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
                    _buildTipCard(
                      '💡 Dica do Dia',
                      'Beba água morna com limão em jejum para acelerar o metabolismo e melhorar a digestão. Aguarde 30 minutos antes do café da manhã.',
                      'Hidratação & Metabolismo',
                      Colors.yellow,
                      Icons.lightbulb,
                      true,
                    ),
                    _buildTipCard(
                      '🍽️ Combinação Perfeita',
                      'Ferro + Vitamina C = Absorção máxima! Combine feijão com laranja ou carne com salada de tomate para otimizar a absorção de ferro.',
                      'Absorção de Nutrientes',
                      Colors.orange,
                      Icons.restaurant_menu,
                      false,
                    ),
                    _buildTipCard(
                      '⏰ Timing Nutricional',
                      'Consuma proteínas até 2h após o treino para maximizar a síntese proteica. Carboidratos antes do treino fornecem energia.',
                      'Performance & Recuperação',
                      Colors.blue,
                      Icons.schedule,
                      false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.pink.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: Colors.pink,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Tem alguma dúvida nutricional?',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: FitnessAppTheme.nearlyDarkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.pink, Colors.purple],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.video_call,
                                          color: FitnessAppTheme.white,
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Consulta Online',
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            color: FitnessAppTheme.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.pink.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.pink.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.message,
                                          color: Colors.pink,
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Chat Direto',
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                            color: Colors.pink,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

  Widget _buildTipCard(
    String title,
    String description,
    String category,
    Color accentColor,
    IconData icon,
    bool isHighlighted,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHighlighted 
              ? accentColor.withOpacity(0.1)
              : FitnessAppTheme.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHighlighted 
                ? accentColor.withOpacity(0.3)
                : FitnessAppTheme.grey.withOpacity(0.2),
            width: isHighlighted ? 2 : 1,
          ),
          boxShadow: isHighlighted ? [
            BoxShadow(
              color: accentColor.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ] : null,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 9,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isHighlighted)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.star,
                      color: FitnessAppTheme.white,
                      size: 12,
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
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: FitnessAppTheme.grey,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Útil',
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.nearlyWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.bookmark_border,
                    color: FitnessAppTheme.grey,
                    size: 12,
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.nearlyWhite,
                    borderRadius: BorderRadius.circular(4),
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