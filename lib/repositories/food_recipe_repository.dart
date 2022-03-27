import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/SigninScreen.dart';
import 'package:cut_corners/home-filled.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/ingredients.dart';
import 'package:cut_corners/repositories/profileInformation.dart';

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
  /*
  void printNutrition()
  {
    print("calories: "+calories.toString());
    print("sugar: "+sugar.toString());
    print("carbohydrates: "+carbohydrates.toString());
    print("protein: "+protein.toString());
    print("fat: "+fat.toString());
    print("fiber: "+fiber.toString());
  }
*/
  Map<String, dynamic> toMap() {
    return
      {
        "calories":calories,
        "sugar":sugar,
        "carbohydrates":carbohydrates,
        "protein":protein,
        "fat":fat,
        "fiber":fiber,
      };
  }
}
class FoodRecipe{
  late List<Ingredient> ingredients=[];
  late String name;
  late int calories;
  late String? photoPath;
  String instructions="";
  int? cookTime;
  late Nutrition nutrition;

  FoodRecipe(this.ingredients,this.name,this.calories,this.photoPath,this.instructions,this.cookTime,this.nutrition);
  FoodRecipe.fromMap(Map<String,dynamic> data, QuerySnapshot<Map<String, dynamic>> ingQSnap, Nutrition nutData){
  for (QueryDocumentSnapshot<Map<String, dynamic>> element in ingQSnap.docs)
    {
      ingredients.add(Ingredient.fromMap(element.data()));
    }
  name=data["name"];
  calories=data["calories"].toInt();
  photoPath=data["photoPath"];
  instructions=data["instructions"];
  nutrition=nutData;

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
          amountNum=brokenNum[tmpAmountNum];
        }
        else{
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
  /*
  void printFood() {
    print("name:$name");
    for(var i in ingredients)
    {
      print(i.amountName);
    }
    print(instructions);
    print("cook time: "+cookTime.toString());
    if(photoPath!=null)print("photoPath: "+ photoPath!);
  }
  */
}

late Map<String,FoodRecipe>foodRecipeRep={};
Future<void> getAllFoodRecipes()
async {
  QuerySnapshot<Map<String, dynamic>> foodRecipeCol = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("food_recipes").get();

  for(QueryDocumentSnapshot<Map<String, dynamic>> food in foodRecipeCol.docs)
  {
    QuerySnapshot<Map<String, dynamic>> ingQSnap = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("food_recipes").doc(food.id).collection("ingredients").get();
    DocumentSnapshot<Map<String, dynamic>> nutritionSnapshot = await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("food_recipes").doc(food.id).collection("nutrition").doc("nutrition").get();
    var nutMap = nutritionSnapshot.data();
    Nutrition nutData=Nutrition.fromMap(nutMap!);
    Map<String, dynamic> data = food.data();
    foodRecipeRep[food.id]=FoodRecipe.fromMap(data,ingQSnap,nutData);
  }
}

Map<String,List<String>> personalMealList=
{
  "breakfast":[],
  "lunch":[],
  "dinner":[],
};
bool personalListNewCreated=false;
late String apiKey;
Future<void> createPersonalMealList(int dayNumber,bool isVegan,bool isVegetarian)
async {
  double dailyNeed=USER.dailyCal;
  var documentSnapshotTmp = await FirebaseFirestore.instance.collection("API").doc("api").get();
  apiKey=documentSnapshotTmp.data()!["apiKey"] as String;
  await getIDsFromAPI(dailyNeed, "breakfast",dayNumber,isVegan,isVegetarian); //personalmeallist + foodreciperep olusma
  await getIDsFromAPI(dailyNeed, "lunch",dayNumber,isVegan,isVegetarian);
  await getIDsFromAPI(dailyNeed, "dinner",dayNumber,isVegan,isVegetarian);
  for(int i=0;i<dayNumber;i++)
    {
      Map<String,String> data={
        "breakfast":personalMealList["breakfast"]![i],
        "lunch":personalMealList["lunch"]![i],
        "dinner":personalMealList["dinner"]![i]
      };
      FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("personalMealList").doc("day${i+1}").set(data);
    }
  await uploadFood();// food_recipes set
  await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).update({"mealListCreated":DateTime.now()});
  personalListNewCreated=true;
  await getPersonalMealList();
  await getAllFoodRecipes();
  await getTodayMealIndex();

  return;
}
Future<void> uploadFood() async {
  for (var key in foodRecipeRep.keys) {
    var food = foodRecipeRep[key];
    final name = food!.name;
    await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("food_recipes").doc(
        name).set(food.toMap());
    for (var i in food.ingredients) {
      FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("food_recipes").doc(
          name).collection("ingredients").doc(i.name).set(i.toMap());
    }
    FirebaseFirestore.instance.collection("Profiles").doc(getUid()).collection("food_recipes").doc(
        name).collection("nutrition").doc("nutrition").set(
        food.nutrition.toMap());
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("ALL_food_recipes").get();
    bool existinAll=false;
    for(var e in snapshot.docs)
      {
        if(e.id==name)
          {
            existinAll=true;
          }
      }
    if(existinAll) continue;
    await FirebaseFirestore.instance.collection("ALL_food_recipes").doc(
        name).set(food.toMap());
    for (var i in food.ingredients) {
      FirebaseFirestore.instance.collection("ALL_food_recipes").doc(
          name).collection("ingredients").doc(i.name).set(i.toMap());
    }
    FirebaseFirestore.instance..collection("ALL_food_recipes").doc(
        name).collection("nutrition").doc("nutrition").set(
        food.nutrition.toMap());
  }
}
/*
void printAllFoodNames()
{
  for(var element in foodRecipeRep.keys)
  {
    print(element);
  }
  print("******DONE*****");
}
*/

