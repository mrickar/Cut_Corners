import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/profilePage.dart';
import 'package:cut_corners/recipe_page.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//FIREBASELERLE RAHAT UGRASAMAK İCİN SAYFA
/*
class tempPage extends StatefulWidget {
  const tempPage({Key? key}) : super(key: key);



  @override
  State<tempPage> createState() => _tempPageState();
}

class _tempPageState extends State<tempPage> {
  bool isFirebaseInit=false;
  @override
  void initState() {
    super.initState();
    initializeFirebase();


  }
  Future<void> initializeFirebase() async{
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInit=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    var foodRecipeRep = FoodRecipeRepository().foodRecipeRep;
    return Scaffold(
      body:isFirebaseInit? ListView.builder(
        itemCount: foodRecipeRep.length+2,
        itemBuilder: (context, index) {
          String key= (index==foodRecipeRep.length)?"Profile":(index==foodRecipeRep.length+1)?"up":foodRecipeRep.keys.elementAt(index);
          return ListTile(
            title: Text(key),
            onTap:(){
              if(index==foodRecipeRep.length+1)
                {
                  //uploadFood();
                  print(FoodRecipeRepository().foodRecipeRep.length);
                  //FoodRecipeRepository().printFoods();

                }
              else if(index==foodRecipeRep.length)
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
              }
              else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: key)));
              }},
          );
        },
      ):
      const CircularProgressIndicator(),
    );
  }

  void uploadFood()
  {
    for (var food in FoodRecipeRepository().foodRecipeRep.keys) {
      final name=FoodRecipeRepository().foodRecipeRep[food]!.name;
      FirebaseFirestore.instance.collection("food_recipe").doc(name).set(FoodRecipeRepository().foodRecipeRep[food]!.toMap());
      for(var i in FoodRecipeRepository().foodRecipeRep["random yemek"]!.ingredients)
      {
        FirebaseFirestore.instance.collection("food_recipe").doc(name).collection("ingredients").doc(i.name).set(i.toMap());
      }
    }
  }
}
*/
class tempPage extends StatefulWidget {
  const tempPage({Key? key}) : super(key: key);



  @override
  State<tempPage> createState() => _tempPageState();
}

class _tempPageState extends State<tempPage> {
  bool isFirebaseInit=false;
  @override
  void initState() {
    super.initState();
  }
  Future<void> initializeFirebase() async{
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInit=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    //var foodRecipeRep = FoodRecipeRepository().foodRecipeRep;
    return Scaffold(
      body:ListView.builder(
        itemCount: foodRecipeRep.length+2,
        itemBuilder: (context, index) {
          String key= (index==foodRecipeRep.length)?"Profile":(index==foodRecipeRep.length+1)?"up":foodRecipeRep.keys.elementAt(index);
          return ListTile(
            title: Text(key),
            onTap:(){
              if(index==foodRecipeRep.length+1)
              {
                //uploadFood();
                print(foodRecipeRep.length);
                //FoodRecipeRepository().printFoods();

              }
              else if(index==foodRecipeRep.length)
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
              }
              else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipePage(foodName: key)));
              }},
          );
        },
      ),
    );
  }

  /*void uploadFood()
  {
    for (var food in FoodRecipeRepository().foodRecipeRep.keys) {
      final name=FoodRecipeRepository().foodRecipeRep[food]!.name;
      FirebaseFirestore.instance.collection("food_recipe").doc(name).set(FoodRecipeRepository().foodRecipeRep[food]!.toMap());
      for(var i in FoodRecipeRepository().foodRecipeRep["random yemek"]!.ingredients)
      {
        FirebaseFirestore.instance.collection("food_recipe").doc(name).collection("ingredients").doc(i.name).set(i.toMap());
      }
    }
  }*/
}