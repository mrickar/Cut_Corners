import 'package:flutter/material.dart';

class MealListEmpty extends StatefulWidget {
  const MealListEmpty({Key? key}) : super(key: key);

  @override
  _MealListEmptyState createState() => _MealListEmptyState();
}

int dayNumber = 0;
int mealNumber = 0;
String dropdownDayValue = 'Enter Day Number';
String dropdownMealValue = 'Enter Meal Number';
final selectionColor = Colors.amber;

class _MealListEmptyState extends State<MealListEmpty> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownDayValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: TextStyle(color: selectionColor),
              underline: Container(
                height: 2,
                color: selectionColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownDayValue = newValue!;
                  dayNumber = int.parse(dropdownDayValue.split(" ")[0]);
                });
              },
              items: <String>['Enter Day Number', '5 days', '10 days', '15 days']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownMealValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: TextStyle(color: selectionColor),
              underline: Container(
                height: 2,
                color: selectionColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownMealValue = newValue!;
                  mealNumber = int.parse(dropdownMealValue.split(" ")[0]);
                });
              },
              items: <String>['Enter Meal Number', '2 meal per day', '3 meal per day']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ),
          const SizedBox(height: 160,),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: selectionColor,
                    child: Text("Save Meal List"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
