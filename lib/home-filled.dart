import 'package:cut_corners/profilePage.dart';
import 'package:flutter/material.dart';

class HomeFilled extends StatefulWidget {
  const HomeFilled({Key? key}) : super(key: key);

  @override
  _HomeFilledState createState() => _HomeFilledState();
}

class _HomeFilledState extends State<HomeFilled> {

  final profileColor = Colors.red.shade700;
  final background = Colors.grey.shade300;
  final mealCard = Colors.grey.shade600;
  final textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: background,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: profileColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                  color: mealCard,
                  height: 100.0,
                  width: 300.0,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: null,
                          backgroundColor: Colors.blue,
                          radius: 40.0,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
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
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                  color: mealCard,
                  height: 100.0,
                  width: 300.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: null,
                          backgroundColor: Colors.blue,
                          radius: 40.0,
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                  color: mealCard,
                  height: 100.0,
                  width: 300.0,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: null,
                          backgroundColor: Colors.blue,
                          radius: 40.0,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
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
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
