//import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/SigninScreen.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:cut_corners/repositories/profileInformation.dart';
import 'package:cut_corners/temp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home-empty.dart';
import 'home-filled.dart';
import 'shopping-list.dart';
import 'meal-list-empty.dart';
import 'meal-list-filled.dart';
import 'questionnaire.dart';

void main() => runApp(const ProviderScope(child: MaterialApp(home: SigninScreen())));
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final bottomNavigatorBack = Colors.red.shade600;
  final bottomNavigatorFront = Colors.grey.shade900;
  int _currentIndex = 1;



  static List<Widget> pages = <Widget>[
    ShoppingList(),//tempPage(),
    mealList.isEmpty ? HomeEmpty() : HomeFilled(),
    mealList.isEmpty ? MealListEmpty() : MealListFilled(),

  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    getUser();
    //PROVIDERLA YAP
    FoodRecipeRepository().getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavigatorBack,
        elevation: 0.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 32),
        unselectedIconTheme: const IconThemeData(size: 24),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: bottomNavigatorFront,
            ),
            label: "Shop list",

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: bottomNavigatorFront,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
              color: bottomNavigatorFront,
            ),
            label: "Meal list",
          ),
        ],
      ),
    );
  }

}

