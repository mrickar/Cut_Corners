import 'dart:io';

import 'package:flutter/material.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({Key? key}) : super(key: key);

  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

List<String> questions = ["name-surname", "height", "weight", "gender", "daily-activity"];
List<String> dropdownQuestions = ["gender", "daily-activity"];
List<String> textFieldQuestions = ["name-surname", "height", "weight"];
List values = [];

final selectionColor = Colors.grey.shade800;

late String name = "";
late int height = 0;
late int weight = 0;
late String gender = "";
late int dailyActivity = 0;

List<Drop> dropdownQ = [
  Drop(header: "gender", items: <String>[' ', 'Male', 'Female']),
  Drop(header: "daily-activity", items: [' ', '1', '2', '3', '4', '5']),
];

List<Field> fieldQ = [
  Field(header: "Name/Surname"),
  Field(header: "height"),
  Field(header: "weight"),
];

class Field{
  final String header;
  late String value;

  Field({required this.header});
}

class FieldTemplate extends StatefulWidget {

  final Field field;

  FieldTemplate({required this.field});

  @override
  _FieldTemplateState createState() => _FieldTemplateState();
}

class _FieldTemplateState extends State<FieldTemplate> {
  late TextEditingController _controllerName;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 286.0,
          height: 54.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xfff7ac32),
          ),
          child: Center(
            child: Text(
              "${widget.field.header}",
              style: TextStyle(
                fontSize: 24.0,
                //fontFamily:
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TextField(
            controller: _controllerName,
            onSubmitted: (String value) {
              widget.field.value = value;
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: selectionColor),
              ),
              labelText: '',
            ),
          ),
        ),
      ],
    );
  }
}


class Drop{
  final String header;
  final List<String> items;
  late String value;

  Drop({required this.header, required this.items});
}

class DropTemplate extends StatefulWidget {

  final Drop drop;


  DropTemplate({required this.drop});

  @override
  _DropTemplateState createState() => _DropTemplateState();
}

class _DropTemplateState extends State<DropTemplate> {

  String dropdownValue = ' ';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 286.0,
          height: 54.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xfff7ac32),
          ),
          child: Center(
            child: Text(
              "${widget.drop.header}",
              style: TextStyle(
                fontSize: 24.0,
                //fontFamily:
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            isExpanded: true,
            elevation: 0,
            style: TextStyle(color: selectionColor),
            underline: Container(
              height: 2,
              color: selectionColor,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                widget.drop.value = newValue;
              });
            },
            items: widget.drop.items
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class _QuestionnaireState extends State<Questionnaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xfff4eae6),
        child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, i) {
              if(dropdownQuestions.contains(questions[i])) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  child: DropTemplate(drop: dropdownQ[questions.length - i - 1],),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  child: FieldTemplate(field: fieldQ[i]),
                );
              }
            }
        ),
      ),
    );
  }
}
