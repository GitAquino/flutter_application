import 'package:flutter/material.dart';
import 'package:flutter_application/src/utils/hex_color.dart';
import '../../../config/fitness_app_theme.dart';
import '../../../models/food_item.dart';

class CategorySelector extends StatefulWidget {
  final FoodCategory? selectedCategory;
  final Function(FoodCategory?) onCategorySelected;
  final AnimationController? animationController;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.animationController,
  });

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector>
    with TickerProviderStateMixin {
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0.2, 0.8, curve: Curves.fastOutSlowIn),
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
                      Row(
                        children: [
                          Text(
                            'Categoria do Alimento',
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: FitnessAppTheme.darkText,
                            ),
                          ),
                          Spacer(),
                          if (widget.selectedCategory != null)
                            GestureDetector(
                              onTap: () => widget.onCategorySelected(null),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: FitnessAppTheme.nearlyDarkBlue
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Limpar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: FitnessAppTheme.nearlyDarkBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: FoodCategoryData.categories.length,
                          itemBuilder: (context, index) {
                            final category = FoodCategoryData.categories[index];
                            final isSelected =
                                widget.selectedCategory == category.category;
                            
                            return GestureDetector(
                              onTap: () {
                                widget.onCategorySelected(
                                    isSelected ? null : category.category);
                              },
                              child: Container(
                                width: 70,
                                margin: EdgeInsets.only(
                                    right: index < FoodCategoryData.categories.length - 1 ? 12 : 0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? HexColor(category.color)
                                            : HexColor(category.color)
                                                .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(25),
                                        border: isSelected
                                            ? Border.all(
                                                color: HexColor(category.color),
                                                width: 2)
                                            : null,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          _getCategoryIcon(category.category),
                                          color: isSelected
                                              ? FitnessAppTheme.white
                                              : HexColor(category.color),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isSelected
                                            ? HexColor(category.color)
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

  IconData _getCategoryIcon(FoodCategory category) {
    switch (category) {
      case FoodCategory.meat:
        return Icons.set_meal;
      case FoodCategory.vegetable:
        return Icons.eco;
      case FoodCategory.fruit:
        return Icons.apple;
      case FoodCategory.grain:
        return Icons.grain;
      case FoodCategory.dairy:
        return Icons.local_drink;
      case FoodCategory.legume:
        return Icons.scatter_plot;
      case FoodCategory.nut:
        return Icons.circle;
      case FoodCategory.seafood:
        return Icons.waves;
      default:
        return Icons.fastfood;
    }
  }
}