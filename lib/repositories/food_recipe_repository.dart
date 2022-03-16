import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/ingredients.dart';
import 'package:cut_corners/repositories/shoppingList_repository.dart';

import 'getFromAPI.dart';

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
    print("calories: "+calories.toString());
    print("sugar: "+sugar.toString());
    print("carbohydrates: "+carbohydrates.toString());
    print("protein: "+protein.toString());
    print("fat: "+fat.toString());
    print("fiber: "+fiber.toString());
  }
}
class FoodRecipe{
  late List<Ingredient> ingredients=[];
  late String name;
  late int calories;
  late String photoPath;
  String instructions="";
  int? cookTime;
  late Nutrition nutrition;

  FoodRecipe(this.ingredients,this.name,this.calories,this.photoPath,this.instructions,this.cookTime,this.nutrition);
  FoodRecipe.fromMap(Map<String,dynamic> data, QuerySnapshot<Map<String, dynamic>> ingQSnap){
  for (QueryDocumentSnapshot<Map<String, dynamic>> element in ingQSnap.docs)
    {
      ingredients.add(Ingredient.fromMap(element.data()));
    }
  //TODO nutrition
  name=data["name"];
  calories=data["calories"].toInt();
  photoPath=data["photoPath"];
  instructions=data["recipe"];
}
  FoodRecipe.fromAPI(Map<String,dynamic> data){
    name=data["name"];
    cookTime=data["total_time_minutes"];
    nutrition=Nutrition.fromMap(data["nutrition"]);
    calories=nutrition.calories;
    photoPath=data["thumbnail_url"];
    var tmpInstructions=data["instructions"];
    for(int i=0;i<tmpInstructions.length;i++)
    {
      var element=tmpInstructions[i];
      instructions=instructions+"\n${i+1}- "+element["display_text"];
    }
    for(var section in data["sections"])
    {
      for (var ing in section["components"])
      {
        var tmpAmountNum;
        double amountNum;
        var tmpAmountType;
        var tmpName;
        if(ing["measurements"].length>0)
        {
          tmpAmountNum=ing["measurements"][0]["quantity"];
          tmpAmountType=ing["measurements"][0]["unit"]["name"];
          for(var element in ing["measurements"])
          {
            if(element["unit"]["name"]=="gram" || element["unit"]["name"]=="milliliter")
            {
              tmpAmountType=element["unit"]["name"];
              tmpAmountNum=element["quantity"];
              break;
            }
          }
          tmpName=ing["ingredient"]["name"];
        }
        else
        {
          tmpAmountNum="0";
          tmpName=ing["raw_text"];
          for(var char in tmpName.split(" "))
          {
            if (double.tryParse(char) != null)
            {
              tmpAmountNum=char;
              break;
            }
          }
          tmpAmountType="";
        }
        if(double.tryParse(tmpAmountNum)!=null)
        {
          amountNum=double.tryParse(tmpAmountNum)!;
        }
        else if(brokenNum.containsKey(tmpAmountNum)){
          print("tmpAmountNum "+tmpAmountNum);
          amountNum=brokenNum[tmpAmountNum];
          print("AmountNum "+amountNum.toString());
        }
        else{
          print("atlanılan ing miktar "+tmpAmountNum);
          continue; //ingredientı ekleme;
        }
        Ingredient tmp=Ingredient(name: tmpName, amountNum: amountNum, amountType: tmpAmountType);
        ingredients.add(tmp);
      }
    }
  }
  Map<String,dynamic> toMap() {
    if(cookTime!=null)
    {
      return {
        "name":name,
        "calories":calories,
        "photoPath":photoPath,
        "instructions":instructions,
        "cookTime":cookTime
      };
    }
    else
    {
      return {
        "name":name,
        "calories":calories,
        "photoPath":photoPath,
        "instructions":instructions
      };
    }
  }
  void printFood() {
    print("name:${name}");
    for(var i in ingredients)
    {
      print(i.amountName);
    }
    print(instructions);
    print("cook time: "+cookTime.toString());

    print("photoPath: "+ photoPath);
    nutrition.printNutrition();
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
  printAllFoodNames();
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


void printAllFoodNames()
{
  for(var element in foodRecipeRep.keys)
  {
    print(element);
  }
  print("******DONE*****");
}
/*
List<FoodRecipe>exampleFoods=[
FoodRecipe(IngList,"yemek1",1000,"images/yemek2.jpg","pişir1"),
FoodRecipe(IngList2,"yemek2",2000,"images/yemek2.jpg","pişir2"),
FoodRecipe(IngList3,"yemek3",3000,"images/yemek2.jpg","pisir3"),
FoodRecipe(IngList4,"yemek4",4000,"images/yemek2.jpg","pisir4"),
FoodRecipe(IngList5,"yemek5",5000,"images/yemek2.jpg","pisir5")
];
*/

