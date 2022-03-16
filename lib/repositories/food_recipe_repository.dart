import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/ingredients.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';

class Nutrition{
  late int calories;
  late int sugar;
  late int carbohydrates;
  late int protein;
  late int fat;
  late int fiber;
  Nutrition.fromMap(Map<String,dynamic> data)
  {
    calories=data["calories"];
    sugar=data["sugar"];
    carbohydrates=data["carbohydrates"];
    protein=data["protein"];
    fat=data["fat"];
    fiber=data["fiber"];
  }
  void printNutrition()
  {
    print("calories: "+calories!.toString());
    print("sugar: "+sugar!.toString());
    print("carbohydrates: "+carbohydrates!.toString());
    print("protein: "+protein!.toString());
    print("fat: "+fat!.toString());
    print("fiber: "+fiber!.toString());
  }
}
class FoodRecipe{
  late List<Ingredient> ingredients=[];
  late String name;
  late int calories;
  late String photoPath;
  late String recipe; //TODO madde madde olacak şekilde ayarla

FoodRecipe(this.ingredients,this.name,this.calories,this.photoPath,this.recipe);
FoodRecipe.fromMap(Map<String,dynamic> data, QuerySnapshot<Map<String, dynamic>> ingQSnap)
{
  for (QueryDocumentSnapshot<Map<String, dynamic>> element in ingQSnap.docs)
    {
      ingredients.add(Ingredient.fromMap(element.data()));
    }
  name=data["name"];
  calories=data["calories"].toInt();
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
Future<void> getAllFoods()
async {
  QuerySnapshot<Map<String, dynamic>> foodRecipeCol = await FirebaseFirestore.instance.collection("food_recipe").get();

  for(QueryDocumentSnapshot<Map<String, dynamic>> food in foodRecipeCol.docs)
  {
    QuerySnapshot<Map<String, dynamic>> ingQSnap = await FirebaseFirestore.instance.collection("food_recipe").doc(food.id).collection("ingredients").get();
    Map<String, dynamic> data = food.data();
    foodRecipeRep[food.id]=FoodRecipe.fromMap(data,ingQSnap);
  }
  //printFoods();
}
/*
Map<String,List<String>> personalMealList=
{
  "breakfast":[],
  "lunch":[],
  "dinner":[],
};
*/
Future<void> createPersonalMealList()//int dayNumber)
async {
  int dayNumber=2;
  List<String> food700=[];
  var querySnapshot = await FirebaseFirestore.instance.collection("calorieList").doc("700-1000").collection("foodNames").get();
  for(var doc in querySnapshot.docs)
    {
      food700.add(doc.data()["name"]);
    }
  List<String> food1000=[];
  querySnapshot = await FirebaseFirestore.instance.collection("calorieList").doc("1000-1300").collection("foodNames").get();
  for(var doc in querySnapshot.docs)
  {
    food1000.add(doc.data()["name"]);
  }
  List<String> food1300=[];
  querySnapshot = await FirebaseFirestore.instance.collection("calorieList").doc("1300-1600").collection("foodNames").get();
  for(var doc in querySnapshot.docs)
  {
    food1300.add(doc.data()["name"]);
  }

  var randomChoose=Random();
  for(int i=0;i<dayNumber;i++)
    {
      /*personalMealList["breakfast"]!.add(food700[randomChoose.nextInt(food700.length)]);
      personalMealList["lunch"]!.add(food1000[randomChoose.nextInt(food1000.length)]);
      personalMealList["dinner"]!.add(food1300[randomChoose.nextInt(food1300.length)]);*/
      var breakfast=food700[randomChoose.nextInt(food700.length)];
      var lunch = food1000[randomChoose.nextInt(food1000.length)];
      var dinner = food1300[randomChoose.nextInt(food1300.length)];
      Map<String,String> data={
        "breakfast":breakfast,
        "lunch":lunch,
        "dinner":dinner
      };
      FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("personalMealList").doc("day${i+1}").set(data);
    }
  await createShoppingList();
  return;
}


void printFoods()
{
  for(var element in foodRecipeRep.keys)
  {
    print(element);
  }
  print("******DONE*****");
}

List<FoodRecipe>exampleFoods=[
FoodRecipe(IngList,"yemek1",1000,"images/yemek2.jpg","pişir1"),
FoodRecipe(IngList2,"yemek2",2000,"images/yemek2.jpg","pişir2"),
FoodRecipe(IngList3,"yemek3",3000,"images/yemek2.jpg","pisir3"),
FoodRecipe(IngList4,"yemek4",4000,"images/yemek2.jpg","pisir4"),
FoodRecipe(IngList5,"yemek5",5000,"images/yemek2.jpg","pisir5")
];
