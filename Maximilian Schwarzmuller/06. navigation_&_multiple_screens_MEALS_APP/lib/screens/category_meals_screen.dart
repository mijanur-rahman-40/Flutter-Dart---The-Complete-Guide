import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

// import '../data/meals_dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedinitData = false;
  // when page is creted or when _CategoryMealsScreenState state is created then initState() is execute
  // @override
  // void initState() {
  //   // init initState routeArguments creates a problem
  //   // cause init state run firstly
  //   // getting data from route
  //   // final routeArguments =
  //   //     ModalRoute.of(context).settings.arguments as Map<String, String>;
  //   // categoryTitle = routeArguments['title'];
  //   // final categoryId = routeArguments['id'];

  //   // displayedMeals = DUMMY_MEALS
  //   //     .where((meal) => meal.categories.contains(categoryId))
  //   //     .toList();

  //   super.initState();
  // }

  // it is called whenever the references of the state chnage
  // it is trigerred initially
  @override
  void didChangeDependencies() {
    print('didChangeDependencies 1 called');
    if (!_loadedinitData) {
      final routeArguments =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArguments['title'];
      final categoryId = routeArguments['id'];

      // displayedMeals = DUMMY_MEALS
      //     .where((meal) => meal.categories.contains(categoryId))
      //     .toList();
          displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedinitData = true;
      print('didChangeDependencies 2 called');
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
      // categoryTitle = 'ggg';
    });
  }

  @override
  Widget build(BuildContext context) {
    // final routeArguments =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryTitle = routeArguments['title'];
    // final categoryId = routeArguments['id'];

    // final categoryMeals = DUMMY_MEALS
    //     .where((meal) => meal.categories.contains(categoryId))
    //     .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            // removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
