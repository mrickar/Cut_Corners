import 'dart:ui';

import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/profilePage.dart';
import 'package:cut_corners/recipe_page.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:cut_corners/repositories/getFromAPI.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


var now = new DateTime.now();
var formatter = new DateFormat('yyyy.MM.dd');
String formattedDate = formatter.format(now);
String weekDay = DateFormat('EEEE').format(now);


class HomeFilled extends StatefulWidget {
  const HomeFilled({Key? key}) : super(key: key);

  @override
  _HomeFilledState createState() => _HomeFilledState();
}

class _HomeFilledState extends State<HomeFilled> {

  final background = Colors.grey.shade300;
  final mealCard = Colors.grey.shade600;
  final textColor = Colors.white;
  final addListColor = Color(0xfff7ac32);
  final profileColor = Color(0xff4297a0);
  final backgroundColor = Color(0xfff4eae6);
  final profilePersonColor = Color(0xffffffff);
  final dateColor = Color(0xff41aeba);
  final addMealColor = Color(0xff595959);
  final rectangularContainerColor = Color(0xfff7ac32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
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
                  "$formattedDate",
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "$weekDay",
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
              ),
            ),
          ),],
        ),
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topRight,
          ),
          const SizedBox(height: 30.0,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[0/*kacinci gün*/].meals[0/*[kahvalti,lunch,dinner]*/],)));
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[0/*kacinci gün*/].meals[1/*[kahvalti,lunch,dinner]*/],)));
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
                        decoration: BoxDecoration(
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[0/*kacinci gün*/].meals[2/*[kahvalti,lunch,dinner]*/],)));
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
                        decoration: BoxDecoration(
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
