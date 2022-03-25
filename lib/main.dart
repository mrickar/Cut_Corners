import 'package:cut_corners/SigninScreen.dart';
import 'package:cut_corners/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home-empty.dart';
import 'home-filled.dart';
import 'shopping-list.dart';
import 'meal-list-empty.dart';
import 'meal-list-filled.dart';



bool mealListCheck = false;
late int todayMealIndex;
late int totalDay;
void main() => runApp(const ProviderScope(child: MaterialApp(home: SigninScreen())));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  final bottomNavigatorBack = Color(0xff9bc0c3);
  final bottomNavigatorIconBack = Color(0xfff7ac32);
  final bottomNavigatorIconFront = Color(0xffffffff);
  int _currentIndex = 1;

  late var futFunc;
  List<Widget> pages = <Widget>[
    const ShoppingList(),//const tempPage(),
    mealListCheck ? MealListEmpty() : mealList.isEmpty ? HomeEmpty() :  HomeFilled(),
    mealList.isEmpty ? MealListEmpty() : MealListFilled(),
  ];
  void checkPages()
  {
    pages=<Widget>[
      const ShoppingList(),//const tempPage(),
      mealListCheck ? MealListEmpty() : mealList.isEmpty ? HomeEmpty() :  HomeFilled(),
      mealList.isEmpty ? MealListEmpty() : MealListFilled(),
    ];
  }


  void onTabTapped(int index) {
    if(makeAgainChc) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {

    setState(() {
      checkPages();
      print("meallist.isEmpty main.dart initstate "+mealList.isEmpty.toString());
    });
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
        //selectedIconTheme: const IconThemeData(size: 32),
        //unselectedIconTheme: const IconThemeData(size: 24),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: bottomNavigatorIconBack,
              radius: 25,
              child: Icon(
                CustomIcons.shopping_list_icon,
                color: bottomNavigatorIconFront,
                size: 50,
              ),
            ),
            label: "Shop list",

          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.home_icon,
              color: bottomNavigatorIconFront,
              size: 50,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: bottomNavigatorIconBack,
              radius: 25,
              child: Icon(
                CustomIcons.meal_icon,
                color: bottomNavigatorIconFront,
                size: 50,
              ),
            ),
            label: "Meal list",
          ),
        ],
      ),
    );
  }

  }

