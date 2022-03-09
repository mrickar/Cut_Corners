import 'package:cut_corners/profilePage.dart';
import 'package:flutter/material.dart';

class HomeFilled extends StatefulWidget {
  const HomeFilled({Key? key}) : super(key: key);

  @override
  _HomeFilledState createState() => _HomeFilledState();
}

class _HomeFilledState extends State<HomeFilled> {

  final background = Colors.grey.shade300;
  final mealCard = Colors.grey.shade600;
  final textColor = Colors.black;
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
                  "04.03.2022",
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Friday",
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
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
          ),
          const SizedBox(height: 30.0,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                    child: Center(
                      child: Container(
                        color: Colors.red,
                        height: 100,
                        width: 300,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 12.0, 0),
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(textColor),
                              ),
                              child: const Text(
                                "Breakfast",
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(75.0, 0, 0, 0),
                      child: CircleAvatar(
                      backgroundImage: null,
                      backgroundColor: Colors.blue,
                      radius: 60.0,
                ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                  child: Center(
                    child: Container(
                      color: Colors.red,
                      height: 100,
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(textColor),
                            ),
                            child: const Text(
                              "Lunch",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 75.0, 0),
                    child: CircleAvatar(
                      backgroundImage: null,
                      backgroundColor: Colors.blue,
                      radius: 60.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                  child: Center(
                    child: Container(
                      color: Colors.red,
                      height: 100,
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12.0, 0),
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(textColor),
                            ),
                            child: const Text(
                              "Dinner",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(75.0, 0, 0, 0),
                    child: CircleAvatar(
                      backgroundImage: null,
                      backgroundColor: Colors.blue,
                      radius: 60.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
