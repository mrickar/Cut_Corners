import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/main.dart';
import 'package:cut_corners/questionnaire.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/profileInformation.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home-filled.dart';
import 'meal-list-filled.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isFirebaseInit=false;
  bool signInChc=false;
  @override
  void initState() {
    super.initState();
    initializeFirebase();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/sign-in-background.jpg'),
            fit: BoxFit.cover
        ),
      ),
      child: Center(
          child: isFirebaseInit ?ElevatedButton(onPressed: () async {
            await signInWithGoogle();
            bool isExistsCheck=await isExists();
            if(isExistsCheck)
            {
              if(signInChc)
                {
                  showDialog(context: context, builder:(context) => const Center(child: CircularProgressIndicator()), );
                  await getUser();
                  await getTodayMealIndex();
                  await getTotalDay();
                  if(totalDay!=0 && todayMealIndex==totalDay)
                  {
                    await deleteMealList_FoodRecipes_ShoppingListFB();
                  }
                  await getPersonalMealList();
                  await  getAllFoodRecipes();
                  await  getTodayMealIndex();
                  Navigator.of(context).pop();
                  signInChc=false;
                }
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Home(),));
            }
            else
            {
              await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Questionnaire(),));
            }
          },
              child: const Text("Sign In with Google")):const CircularProgressIndicator(),
      )
    ) ;
  }
  Future<void> initializeFirebase() async{
    await Firebase.initializeApp();
    if(getUid()!=null)
      {
        await getUser();
        await getTodayMealIndex();
        await getTotalDay();
        if(totalDay!=0 && todayMealIndex==totalDay)
        {
          await deleteMealList_FoodRecipes_ShoppingListFB();
        }
        await getPersonalMealList();
        await  getAllFoodRecipes();
        await  getTodayMealIndex();
      }
    else
      {
        signInChc=true;
      }
    setState(() {
      isFirebaseInit=true;
    });

    bool isExistsCheck=await isExists();
    setState(() {
      if(isExistsCheck)
      {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),));
      }
    });
  }
}
Future<void> getPersonalMealList() async {
  var querySnapshot = await FirebaseFirestore.instance.collection("Profiles")
      .doc(getUid()).collection("personalMealList")
      .get();
  for (int i = 1; i < querySnapshot.docs.length + 1; i++) {
    var documentSnapshot = await FirebaseFirestore.instance.collection(
        "Profiles").doc(getUid()).collection("personalMealList")
        .doc("day$i")
        .get();
    Map<String, dynamic>? mealOfDay = documentSnapshot.data();
    List<String> dailyMeal = [
      mealOfDay!["breakfast"],
      mealOfDay["lunch"],
      mealOfDay["dinner"]
    ];
    mealList.add(Daily(meals: dailyMeal));
  }
    isMealListReady = true;
    createShoppingList();
}
Future<void> getTotalDay()
async {
  var querySnapshot = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("personalMealList").get();
  totalDay=querySnapshot.size;
  return;
}