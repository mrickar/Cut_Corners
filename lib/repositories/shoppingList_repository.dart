import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/shopping-list.dart';
import 'package:cut_corners/repositories/ingredients.dart';

Map<String,Ingredient> allIngMap={};

Future<void> createShoppingList() async {
  if (personalListNewCreated) {
    for (var dailyMeal in mealList) {
      for (var mealName in dailyMeal.meals) {
        var querySnapshot = await FirebaseFirestore.instance.collection(
            "Profiles").doc(getUid()).collection("food_recipes")
            .doc(mealName)
            .collection("ingredients")
            .get();
        for (var doc in querySnapshot.docs) {
          Ingredient newIng = Ingredient.fromMap(doc.data());
          if (!allIngMap.containsKey(doc.data()["name"])) {
            if (doc.data()["amountNum"] == 0) continue;
            allIngMap[doc.data()["name"]] = newIng;
          }
          else {
            //TODO amountType farkliysa patliyor
            if (allIngMap[doc.data()["name"]]!.amountType == newIng.amountType) {
              allIngMap[doc.data()["name"]]!.amountNum += newIng.amountNum;
            }
            else {
              /*
              print(allIngMap[doc.data()["name"]]!.name + " icin\n " +
                  allIngMap[doc.data()["name"]]!.amountType + " , " +
                  doc.data()["amountType"]);
               */
            }
          }
        }
      }
    }
    for (var key in allIngMap.keys) {
      var item = allIngMap[key];
      var newItem = item!.toMap();
      newItem["owned"] = false;
      FirebaseFirestore.instance.collection("Profiles").doc(getUid())
          .collection("shoppingList").doc(item.name)
          .set(newItem);
    }
    all=allIngMap.values.toList();
    needs=allIngMap.values.toList();
    personalListNewCreated=false;
  }
  else {
    var querySnapshot = await FirebaseFirestore.instance.collection("Profiles")
        .doc(getUid()).collection("shoppingList")
        .get();
    for (var doc in querySnapshot.docs) {
      Ingredient newIng = Ingredient.fromMap(doc.data());
      if (!allIngMap.containsKey(doc.data()["name"])) {
        if (doc.data()["amountNum"] == 0) continue;
        allIngMap[doc.data()["name"]] = newIng;
        if (doc.data()["owned"] == true) {
          owned.add(newIng);
        }
        else
          {
            needs.add(newIng);
          }
      }
      else {
        //TODO amountType farkliysa patliyor
        if (allIngMap[doc.data()["name"]]!.amountType == newIng.amountType) {
          allIngMap[doc.data()["name"]]!.amountNum += newIng.amountNum;
        }
        else {
          /*
          print(allIngMap[doc.data()["name"]]!.name + " icin\n " +
              allIngMap[doc.data()["name"]]!.amountType + " , " +
              doc.data()["amountType"]);

           */
        }
      }
    }
    all=allIngMap.values.toList();
  }
}