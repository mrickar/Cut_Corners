import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/ingredients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodRecipe{
  late List<Ingredient> ingredients=[];
  late String name;
  late int calories;
  late String photoPath;
  late String recipe; //TODO madde madde olacak şekilde ayarla

FoodRecipe(this.ingredients,this.name,this.calories,this.photoPath,this.recipe);
FoodRecipe.fromMap(Map<String,dynamic> data, QuerySnapshot<Map<String, dynamic>> ingQSnap)
{
  List<Ingredient> ingredientsTmp=[];

  for (QueryDocumentSnapshot<Map<String, dynamic>> element in ingQSnap.docs)
    {
      ingredients.add(Ingredient.fromMap(element.data()));
    }

  //ingredients=ingredientsTmp;
  name=data["name"];
  calories=data["calories"];
  photoPath=data["photoPath"];
  recipe=data["recipe"];
}
Map<String,dynamic> toMap()
{

  return {
    "name":name,
    "calories":calories,
    "photoPath":photoPath,
    "recipe":recipe
  };
}
}
late Map<String,FoodRecipe>foodRecipeRep={};
Future<void> getFoods()
async {
  QuerySnapshot<Map<String, dynamic>> foodRecipeCol = await FirebaseFirestore.instance.collection("food_recipe").get();

  for(QueryDocumentSnapshot<Map<String, dynamic>> food in foodRecipeCol.docs)
  {
    QuerySnapshot<Map<String, dynamic>> ingQSnap = await FirebaseFirestore.instance.collection("food_recipe").doc(food.id).collection("ingredients").get();
    Map<String, dynamic> data = food.data();
    foodRecipeRep[food.id]=FoodRecipe.fromMap(data,ingQSnap);
  }
  printFoods();
}
void printFoods()
{
  for(var element in foodRecipeRep.keys)
  {
    print(element);
  }
  print("******DONE*****");
}
