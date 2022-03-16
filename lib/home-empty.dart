import 'dart:ui';

import 'package:cut_corners/main.dart';
import 'package:cut_corners/profilePage.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


var now = new DateTime.now();
var formatter = new DateFormat('yyyy.MM.dd');
String formattedDate = formatter.format(now);
String weekDay = DateFormat('EEEE').format(now);

class HomeEmpty extends StatefulWidget {
  const HomeEmpty({Key? key}) : super(key: key);

  @override
  _HomeEmptyState createState() => _HomeEmptyState();
}
class _HomeEmptyState extends State<HomeEmpty> {

  final addListColor = Color(0xfff7ac32);
  final profileColor = Color(0xff4297a0);
  final backgroundColor = Color(0xfff4eae6);
  final profilePersonColor = Color(0xffffffff);
  final dateColor = Color(0xff41aeba);
  final addMealColor = Color(0xff595959);

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
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));},
              ),
            ),
          ),],
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
            ),
            Ink(
              width: 120.0,
              height: 120.0,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.add_circle,
                      size: 96.0,
                      color: addListColor,
                    ),
                  ),
                  onPressed: () async {
                  await createPersonalMealList(10,false,false);
                  print("**********create sonra********");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home(),));
                },
              ),

            ),
            //const SizedBox(height: 24.0,),
            Text(
              "Add Meal",
              style: TextStyle(
                fontSize: 36.0,
                color: addMealColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


