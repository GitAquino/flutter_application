import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';

class ShoppingListSection extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ShoppingListSection({Key? key, this.animationController, this.animation})
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
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.purple,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Lista de Compras',
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
                                  'Baseada no seu plano nutricional',
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
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                '12 itens',
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
                    _buildCategorySection(
                      'Proteínas 🥩',
                      [
                        ShoppingItem('Peito de frango', '500g', false),
                        ShoppingItem('Ovos', '1 dúzia', true),
                        ShoppingItem('Salmão', '300g', false),
                      ],
                      Colors.red,
                    ),
                    _buildCategorySection(
                      'Vegetais 🥬',
                      [
                        ShoppingItem('Brócolis', '1 maço', true),
                        ShoppingItem('Cenoura', '500g', false),
                        ShoppingItem('Espinafre', '1 maço', false),
                      ],
                      Colors.green,
                    ),
                    _buildCategorySection(
                      'Carboidratos 🍞',
                      [
                        ShoppingItem('Batata doce', '1kg', false),
                        ShoppingItem('Aveia', '500g', true),
                        ShoppingItem('Arroz integral', '1kg', false),
                      ],
                      Colors.orange,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.blue.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Adicionar Item',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.purple.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.purple,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Compartilhar',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildCategorySection(
    String title,
    List<ShoppingItem> items,
    Color categoryColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: categoryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: categoryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: categoryColor,
              ),
            ),
            SizedBox(height: 8),
            ...items.map((item) => _buildShoppingItem(item, categoryColor)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildShoppingItem(ShoppingItem item, Color categoryColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: item.isChecked ? categoryColor : Colors.transparent,
              border: Border.all(
                color: categoryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: item.isChecked
                ? Icon(
                    Icons.check,
                    color: FitnessAppTheme.white,
                    size: 14,
                  )
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: item.isChecked
                    ? FitnessAppTheme.grey.withOpacity(0.6)
                    : FitnessAppTheme.nearlyDarkBlue,
                decoration: item.isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          Text(
            item.quantity,
            style: TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.normal,
              fontSize: 10,
              color: FitnessAppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingItem {
  final String name;
  final String quantity;
  final bool isChecked;

  ShoppingItem(this.name, this.quantity, this.isChecked);
}