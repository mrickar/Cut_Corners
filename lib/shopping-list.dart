import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/ingredients.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/*class Ingredient{
  late String name;
  late int amount;
  late String amountType;
  //late bool isDrink;

  //Ingredient(this.name,this.amount,this.amountType,this.isDrink);
  Ingredient({required this.name, required this.amount, required this.amountType});
}*/

/*List<Ingredient> _all = [
  Ingredient(name: "rice", amountNum: 2, amountType: "kg"),
  Ingredient(name: "olive oil", amountNum: 1, amountType: "L"),
];*/
List<Ingredient> all = allIngMap.values.toList();
List<Ingredient> needs = [];
List<Ingredient> owned = [];

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  final titleColor = Color(0xff4297a0);
  final titleTextColor = Color(0xffffffff);
  final listBackground = Color(0xff9bc0c3);
  final backgroundColor = Color(0xfff4eae6);
  final itemTextColor = Color(0xffffffff);


  @override
  Widget build(BuildContext context) {

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: titleColor,
                height: 38,
                width: 232,
                child: Center(
                  child: Text(
                      "Shopping List",
                      style: TextStyle(
                        color: titleTextColor,
                        fontSize: 18.0,
                        fontFamily: 'Lexend Peta',
                        fontWeight: FontWeight.w400,
                      ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: all.length,
                  itemExtent: 70,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 0.0,
                      color: listBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child:Text(
                                  (isInteger(all[i].amountNum)?(all[i].amountNum.toInt().toString()):all[i].amountNum.toString()) + " " + all[i].amountType,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  color: itemTextColor,
                                  fontFamily: 'Lexend Peta',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: nameOfFoodTextWidget(all[i].name),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                needs.contains(all[i]) ? Icons.check_box_outline_blank : Icons.check_box,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            if(needs.contains(all[i])) {
                              needs.remove(all[i]);
                              owned.add(all[i]);
                              FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("shoppingList").doc(all[i].name).update({"owned":true});
                            }
                            else {
                              owned.remove(all[i]);
                              needs.add(all[i]);
                              FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("shoppingList").doc(all[i].name).update({"owned":false});
                            }
                          });
                        },
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );

  }
  Widget nameOfFoodTextWidget(String foodName) {
    if (hasTextOverflow(foodName, TextStyle(color: itemTextColor,
      fontFamily: 'Lexend Peta',
      fontWeight: FontWeight.w400,))) {
      return Marquee(
        text: foodName,
        style: TextStyle(
          color: itemTextColor,
          fontFamily: 'Lexend Peta',
          fontWeight: FontWeight.w400,
        ),
        scrollAxis: Axis.horizontal,
        blankSpace: 50.0,
        velocity: 50.0,
        pauseAfterRound: Duration(seconds: 2),
        startAfter: Duration(seconds: 2),
        //startPadding: -300.0,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
        //numberOfRounds: 1,
      );
    }
    else {
      return Text(
        foodName,
        style: TextStyle(
          color: itemTextColor,
          fontFamily: 'Lexend Peta',
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }
}
bool isInteger(num value) =>
    value is int || value == value.roundToDouble();

bool hasTextOverflow(
    String text,
    TextStyle style,
    {double minWidth = 0,
      double maxWidth = 175,
      int maxLines = 1
    }) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);
  return textPainter.didExceedMaxLines;
}
