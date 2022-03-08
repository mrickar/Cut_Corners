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

class FoodRecipeRepository extends ChangeNotifier{
  late Map<String,FoodRecipe>foodRecipeRep={};/*=
  {
    "random yemek":FoodRecipe(IngredientRepository().IngList,"random yemek",1000,"images/yemek1.jpg","PisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisirPisir"),
    "güzel yemek":FoodRecipe(IngredientRepository().IngList,"güzel yemek",2000,"images/yemek2.jpg","Pisir"),
    "yemekhane yemek":FoodRecipe(IngredientRepository().IngList,"yemekhane yemek",10,"images/yemek3.jpg","Pisir"),
  };*/
  //List<FoodRecipe>FoodRecipeRep=[FoodRecipe(IngredientRepository().IngList,"random yemek",1000,"images/yemek1.jpg","Pisir")];

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
  Future<Map<String, FoodRecipe>> makeFoodList()
  async {
    await getFoods();
    return foodRecipeRep;
  }

  void printFoods()
  {
    for(var element in foodRecipeRep.keys)
      {
        print(element);
      }
    print("******DONE*****");
  }
}



final FoodProvider=ChangeNotifierProvider((ref) => FoodRecipeRepository());

final FoodRepProvider=FutureProvider((ref) => ref.watch(FoodProvider).makeFoodList(),);