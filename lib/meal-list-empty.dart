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
final dropdownbackground = Color(0xff9bc0c3);
final dropdownTextColor = Color(0xffffffff);
final recreateButtonColor = Color(0xffff6b00);
final recreateTextColor = Color(0xffffffff);

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
        SizedBox(height: 50,),
        Container(
          color: dropdownbackground,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              isExpanded: false,
              value: dropdownDayValue,
              icon: const Icon(Icons.arrow_drop_down_circle_rounded),
              elevation: 16,
              style: TextStyle(
                  color: dropdownTextColor,
                  fontFamily: 'Lexend Peta',
                  fontWeight: FontWeight.w400,
              ),
              dropdownColor: dropdownbackground,
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
            ),
          ),
        ),
        const SizedBox(height: 130,),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: recreateButtonColor,
            height: 47.0,
            width: 197.0,
            child: TextButton(
              child: Text(
                "Make a Meal List",
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
    );
  }
}
