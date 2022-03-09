import 'package:flutter/material.dart';

class MealListFilled extends StatefulWidget {
  const MealListFilled({Key? key}) : super(key: key);

  @override
  _MealListFilledState createState() => _MealListFilledState();
}

class Daily{
  final int mealCount;
  final List meals;

  Daily({required this.mealCount, required this.meals});
}

const dayBackgroundColor = Colors.greenAccent;
final mealTextColor = Colors.grey.shade800;

List<Daily> mealList = [
  /*
  Daily(mealCount:2, meals:["wrap", "cesar salad"]),
  Daily(mealCount: 2, meals: ["spaghetti", "pasta"]),
  */
];

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
                  color: mealTextColor,
                  fontSize: 12.0,
                ),
            ),
          ),
        ),
        Column(
          children: daily.meals.map((meal) => Text(
              "$meal",
              style: TextStyle(
                color: mealTextColor,
                fontSize: 24.0,
              ),
          )).toList(),
        ),
      ],
    ),
  );
}

class _MealListFilledState extends State<MealListFilled> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: mealList.length,
          itemBuilder: (context, i) {
            return dailyMealTemplate(mealList[i], i+1);
          }
      ),
    );
  }
}
