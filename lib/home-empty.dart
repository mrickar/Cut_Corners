import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeEmpty extends StatefulWidget {
  const HomeEmpty({Key? key}) : super(key: key);

  @override
  _HomeEmptyState createState() => _HomeEmptyState();
}
//todo NAPION hop
class _HomeEmptyState extends State<HomeEmpty> {

  final addListColor = Colors.red.shade700;
  final profileColor = Colors.red.shade700;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey.shade300,
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
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 200.0,),
            Ink(
              width: 120.0,
              height: 120.0,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(
                    Icons.add_circle_outline,
                    size: 96.0,
                    color: addListColor,
                ),
                onPressed: () {},
              ),
            ),
            //const SizedBox(height: 24.0,),
            Text(
              "Create Meal List",
              style: TextStyle(
                fontSize: 36.0,
                color: addListColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


