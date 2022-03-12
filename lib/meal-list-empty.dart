import 'package:cut_corners/questionnaire.dart';
import 'package:flutter/material.dart';

class MealListEmpty extends StatefulWidget {
  const MealListEmpty({Key? key}) : super(key: key);

  @override
  _MealListEmptyState createState() => _MealListEmptyState();
}

int dayNumber = 0;
String dropdownDayValue = 'Enter Day Number';
final selectionColor = Colors.amber;
final questionBackground = Color(0xfff7ac32);
final questionTextColor = Color(0xffffffff);

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
    return Column(
      children: [
        const SizedBox(height: 180,),
        SizedBox(
          width: 289.0,
          height: 99.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: questionBackground,
            ),
            child: Center(
              child: Text(
                "Choose How Many Days You Want to Plan",
                style: TextStyle(
                  color: questionTextColor,
                  fontSize: 20.0,
                  fontFamily: 'Lexend Peta',
                  fontWeight: FontWeight.w400,
                  //fontFamily:
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );

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
          const SizedBox(height: 160,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
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
