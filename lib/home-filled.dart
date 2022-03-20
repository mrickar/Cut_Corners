import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/profilePage.dart';
import 'package:cut_corners/recipe_page.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';


var now = DateTime.now();
var formatter = DateFormat('yyyy.MM.dd');
String formattedDate = formatter.format(now);
String weekDay = DateFormat('EEEE').format(now);
enum mealTimes{
  breakfast,
  lunch,
  dinner,
}

class HomeFilled extends StatefulWidget {
  const HomeFilled({Key? key}) : super(key: key);

  @override
  _HomeFilledState createState() => _HomeFilledState();
}

class _HomeFilledState extends State<HomeFilled> {

  final background = Colors.grey.shade300;
  final mealCard = Colors.grey.shade600;
  final textColor = Colors.white;
  final addListColor = const Color(0xfff7ac32);
  final profileColor = const Color(0xff4297a0);
  final backgroundColor = const Color(0xfff4eae6);
  final profilePersonColor = const Color(0xffffffff);
  final dateColor = const Color(0xff41aeba);
  final addMealColor = const Color(0xff595959);
  final rectangularContainerColor = const Color(0xfff7ac32);

  @override
  void initState() {

    if(todayMealIndex>=mealList.length)
    {
      //TODO UNCOMMENT TO DELETE DATA WHEN DAY IS UP
      //deleteMealList_FoodRecipes_ShoppingListFB();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  weekDay,
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: profileColor,
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: profilePersonColor,
                  size: 24.0,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
                  //deleteMealList_FoodRecipes_ShoppingListFB();
                  },
              ),
            ),
          ),],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30.0,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[todayMealIndex].meals[mealTimes.breakfast.index],)));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                      child: Center(
                        child: Container(
                          color: rectangularContainerColor,
                          height: 100,
                          width: 300,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 12.0, 0),
                              child: Text(
                                "BREAKFAST",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Lexend Peta',
                                  fontWeight: FontWeight.w400,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(65.0, 6.0, 0, 0),
                        child: Container(
                          width: 120, height: 120,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(60),
                              )
                          ),
                          child: Image.asset('images/breakfast-icon.png', fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[todayMealIndex].meals[mealTimes.lunch.index],)));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                    child: Center(
                      child: Container(
                        color: rectangularContainerColor,
                        height: 100,
                        width: 300,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                            child: Text(
                              "LUNCH",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Lexend Peta',
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6.0, 65.0, 0),
                      child: Container(
                        width: 120, height: 120,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            )
                        ),
                        child: Image.asset('images/lunch-icon.png', fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[todayMealIndex].meals[mealTimes.dinner.index],)));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                    child: Center(
                      child: Container(
                        color: rectangularContainerColor,
                        height: 100,
                        width: 300,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 12.0, 0),
                            child: Text(
                              "DINNER",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Lexend Peta',
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(65.0, 6.0, 0, 0),
                      child: Container(
                        width: 120, height: 120,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            )
                        ),
                        child: Image.asset('images/dinner-icon.png', fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> getTodayMealIndex()
async {
  List<int>monthsDays=[0,31,28,31,30,31,30,31,31,30,31,30,31];
  var documentSnapshot = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).get();
  var firstCreatedTimeTS=documentSnapshot.data()!["mealListCreated"] as Timestamp;
  var firstCreatedTime = firstCreatedTimeTS.toDate();
  var now =DateTime.now();

  todayMealIndex=(now.day-firstCreatedTime.day)%monthsDays[firstCreatedTime.month];
  return;
}
