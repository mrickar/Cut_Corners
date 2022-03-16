import 'package:flutter/material.dart';

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
              children: daily.meals.map((meal) => Text(
                  "$meal",
                  style: TextStyle(
                    color: mealTextColor,
                    fontSize: 16.0,
                    fontFamily: 'Lexend Peta',
                    fontWeight: FontWeight.w400,
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
                  return dailyMealTemplate(mealList[i], i+1);
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
