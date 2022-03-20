import 'dart:ui';

import 'package:cut_corners/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealListFilled extends StatefulWidget {
  const MealListFilled({Key? key}) : super(key: key);

  @override
  _MealListFilledState createState() => _MealListFilledState();
}

class Daily{
  final List meals;

  Daily({required this.meals});
}

const dayBackgroundColor = Color(0xff9bc0c3);
final mealTextColor = Color(0xff595959);
final recreateButtonColor = Color(0xffff6b00);
final recreateTextColor = Color(0xffffffff);
final dayNumberColor = Color(0xfff4eae6);
final bacgroundColor = Color(0xfff4eae6);

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
final poppedDayTextColor = Color(0xff595959);

List<Daily> mealList = [];

var now = DateTime.now();
var formatter = DateFormat('yyyy.MM.dd');
String formattedDate = formatter.format(now);
String weekDay = DateFormat('EEEE').format(now);

Widget dailyMealTemplate(Daily daily, int i) {

  return Card(
      color: dayBackgroundColor,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                  "Day $i",
                  style: TextStyle(
                    color: dayNumberColor,
                    fontSize: 12.0,
                    fontFamily: 'Lexend Peta',
                    fontWeight: FontWeight.w400,
                  ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 8.0, 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: daily.meals.map((meal) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                      "-$meal",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: mealTextColor,
                        fontSize: 16.0,
                        fontFamily: 'Lexend Peta',
                        fontWeight: FontWeight.w400,
                      ),
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
}

class _MealListFilledState extends State<MealListFilled> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bacgroundColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: mealList.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                      child: dailyMealTemplate(mealList[i], i+1),
                      onTap: () => showDialog<void>(
                        context: context,
                        barrierDismissible: true, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                "Day ${i+1}\n" + formattedDate + " " + weekDay,
                                style: TextStyle(
                                  fontFamily: 'Lexend Peta',
                                  fontWeight: FontWeight.w400,
                                  color: poppedDayTextColor,
                                ),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[i].meals[0],)));
                                      },
                                      child: Center(
                                        child: Container(
                                          color: rectangularContainerColor,
                                          height: 100,
                                          width: 300,
                                          child: Center(
                                            child: Text(
                                              mealList[i].meals[0],
                                              textAlign: TextAlign.center,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[i].meals[1],)));
                                      },
                                      child: Center(
                                        child: Container(
                                          color: rectangularContainerColor,
                                          height: 100,
                                          width: 300,
                                          child: Center(
                                            child: Text(
                                              mealList[i].meals[1],
                                              textAlign: TextAlign.center,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: mealList[i].meals[2],)));
                                      },
                                      child: Center(
                                        child: Container(
                                          color: rectangularContainerColor,
                                          height: 100,
                                          width: 300,
                                          child: Center(
                                            child: Text(
                                              mealList[i].meals[2],
                                              textAlign: TextAlign.center,
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
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  );
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: recreateButtonColor,
              height: 47.0,
              width: 134.0,
              child: TextButton(
                child: Text(
                  "Make Again",
                  style: TextStyle(
                    color: recreateTextColor,
                    fontSize: 14.0,
                    fontFamily: 'Krona One',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );

  }
}
