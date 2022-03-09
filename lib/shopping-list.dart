import 'package:cut_corners/repositories/ingredients.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';
import 'package:flutter/material.dart';

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
List<Ingredient> _all = all.values.toList();
List<Ingredient> _needs = [
  Ingredient(name: "rice", amountNum: 2, amountType: "kg"),
  Ingredient(name: "olive oil", amountNum: 1, amountType: "L"),
];
List<Ingredient> _owned = [];

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  final background = Colors.grey.shade300;
  final profileColor = Colors.red.shade700;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
          itemCount: _all.length + 1,
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            final index = i ~/ 2;

            return ListTile(
              leading: Text(_all[index].amountNum.toString() + " " + _all[index].amountType),
              title: Text(_all[index].name),
              trailing: Icon(
                !_needs.contains(_all[index]) ? Icons.check_box_outline_blank : Icons.check_box,
              ),
              onTap: () {
                setState(() {
                  if(_needs.contains(_all[index])) {
                    _needs.remove(_all[index]);
                    _owned.add(_all[index]);
                  }
                  else {
                    _owned.remove(_all[index]);
                    _needs.add(_all[index]);
                  }
                });
              },
            );
          }
      ),
    );
  }
}


