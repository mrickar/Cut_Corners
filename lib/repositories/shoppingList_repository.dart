import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/meal-list-filled.dart';
import 'package:cut_corners/repositories/googleSign.dart';

import 'ingredients.dart';

class shoppingListRep{

}

Map<String,Ingredient> all={};

Future<void> createShoppingList()
async {
  for(var dailyMeal in mealList)
    {
      for (var mealName in dailyMeal.meals)
        {
          var querySnapshot = await FirebaseFirestore.instance.collection("food_recipe").doc(mealName).collection("ingredients").get();
          for(var doc in querySnapshot.docs)
            {
              if(!all.containsKey(doc.data()["name"]))
                {
                  all[doc.data()["name"]]=Ingredient.fromMap(doc.data());
                }
              else
                {
                  //TODO amountType farkliysa patliyor
                  all[doc.data()["name"]]!.amountNum+=doc.data()["amountNum"] as double;
                }
            }
        }
    }

  for(var key in all.keys)
    {
      var item=all[key];
      FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("shoppingList").doc(item!.name).set(item.toMap());
    }

}