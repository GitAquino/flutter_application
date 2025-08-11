import 'package:flutter/material.dart';
import '../../config/fitness_app_theme.dart';
import '../../models/meal_list_model.dart';
import '../../models/food_item_model.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key, this.animationController});

  final AnimationController? animationController;

  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  List<MealListModel> mealLists = [];
  double topBarOpacity = 0.0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    // Dados de exemplo
    _loadSampleData();
    super.initState();
  }

  void _loadSampleData() {
    mealLists = [
      MealListModel(
        id: '1',
        name: 'Café da Manhã Saudável',
        description: 'Lista de alimentos para um café da manhã nutritivo',
        foodItems: [
          FoodItemModel(
            name: 'Aveia',
            weight: 50,
            preparationType: 'Cozida',
            calories: 190,
            protein: 6.8,
            carbs: 32.0,
            fat: 3.4,
          ),
          FoodItemModel(
            name: 'Banana',
            weight: 100,
            preparationType: 'In natura',
            calories: 89,
            protein: 1.1,
            carbs: 22.8,
            fat: 0.3,
          ),
        ],
        createdAt: DateTime.now().subtract(Duration(days: 2)),
      ),
      MealListModel(
        id: '2',
        name: 'Almoço Proteico',
        description: 'Refeição rica em proteínas para ganho de massa',
        foodItems: [
          FoodItemModel(
            name: 'Peito de Frango',
            weight: 150,
            preparationType: 'Grelhado',
            calories: 248,
            protein: 46.2,
            carbs: 0,
            fat: 5.4,
          ),
        ],
        createdAt: DateTime.now().subtract(Duration(days: 1)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),

      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: mealLists.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController!,
                          curve: Interval((1 / mealLists.length) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
              widget.animationController?.forward();
              return MealListCard(
                mealList: mealLists[index],
                animation: animation,
                animationController: widget.animationController!,
                onTap: () => _navigateToMealDetail(mealLists[index]),
                onDelete: () => _deleteMealList(mealLists[index].id),
              );
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Lista Alimentar',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () => _showCreateMealListDialog(),
                                child: Center(
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: FitnessAppTheme.nearlyDarkBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: FitnessAppTheme.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: FitnessAppTheme.nearlyDarkBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: FitnessAppTheme.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  void _showCreateMealListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateMealListDialog(
          onSave: (String name, String description) {
            _createMealList(name, description);
          },
        );
      },
    );
  }

  void _createMealList(String name, String description) {
    final newMealList = MealListModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      foodItems: [],
      createdAt: DateTime.now(),
    );

    setState(() {
      mealLists.insert(0, newMealList);
    });
  }

  void _deleteMealList(String id) {
    setState(() {
      mealLists.removeWhere((meal) => meal.id == id);
    });
  }

  void _navigateToMealDetail(MealListModel mealList) {
    // TODO: Navegar para tela de detalhes da lista
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abrindo detalhes de "${mealList.name}"'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }
}

class MealListCard extends StatelessWidget {
  const MealListCard({
    super.key,
    required this.mealList,
    required this.animationController,
    required this.animation,
    required this.onTap,
    required this.onDelete,
  });

  final MealListModel mealList;
  final AnimationController animationController;
  final Animation<double> animation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
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
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    mealList.name,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: FitnessAppTheme.nearlyDarkBlue,
                                    ),
                                  ),
                                  if (mealList.description.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        mealList.description,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: FitnessAppTheme.grey
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: onDelete,
                              icon: Icon(
                                Icons.delete_outline,
                                color: FitnessAppTheme.grey,
                                size: 20,
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
                            Text(
                              '${mealList.foodItems.length} alimentos',
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: FitnessAppTheme.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${mealList.totalCalories.toStringAsFixed(0)} kcal',
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: FitnessAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.restaurant_menu,
                              color: FitnessAppTheme.nearlyBlue,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Toque para ver detalhes',
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: FitnessAppTheme.nearlyBlue,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.picture_as_pdf,
                              color: FitnessAppTheme.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'PDF',
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: FitnessAppTheme.grey,
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
          ),
        );
      },
    );
  }
}

class CreateMealListDialog extends StatefulWidget {
  const CreateMealListDialog({super.key, required this.onSave});

  final Function(String name, String description) onSave;

  @override
  _CreateMealListDialogState createState() => _CreateMealListDialogState();
}

class _CreateMealListDialogState extends State<CreateMealListDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Nova Lista Alimentar',
        style: TextStyle(
          fontFamily: FitnessAppTheme.fontName,
          fontWeight: FontWeight.w600,
          color: FitnessAppTheme.nearlyDarkBlue,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Lista *',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: FitnessAppTheme.nearlyBlue),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nome é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: FitnessAppTheme.nearlyBlue),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: TextStyle(color: FitnessAppTheme.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(
                _nameController.text.trim(),
                _descriptionController.text.trim(),
              );
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: FitnessAppTheme.nearlyBlue,
          ),
          child: Text(
            'Criar',
            style: TextStyle(color: FitnessAppTheme.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}