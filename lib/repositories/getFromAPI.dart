import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'food_recipe_repository.dart';

Map<String,dynamic> brokenNum= {
  "¼":0.25,
  "Â¼":0.25,
  "¾":0.75,
  "Â¾":0.75,
  "½":0.5,
  "Â½":0.5,
};
/*
Future<void> getIDsFromAPI(double dailyNeed,String mealTime,int numberOfMealDay,bool isVegan,bool isVegetarian) //tastyfood
async {
  //String mealTime="breakfast";//"lunch", "dinner"
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/list";
  //const url = "https://tasty.p.rapidapi.com/recipes/list";
  const headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': apiKey
  };
  String tags=mealTime; //healthy ekle ;
  if(isVegan) {
    tags+=",vegan";
  }
  else if(isVegetarian)
  {
    tags+=",vegetarian";
  }
  final queryString = {"from":Random().nextInt(10).toString(),"size":"40","tags":tags,"num_servings":"1"};//,"tags":"under_30_minutes"};//TODO TAKE QUERY
  Uri uri = Uri.https(authority,unencodedPath,queryString);
  http.Response response = await http.get(uri,headers: headers);
  final data=await jsonDecode(response.body);
  List<int> idList=[];
  for(var element in data["results"])
  {
    idList.add(element["id"]);
  }
  await getInformationsFromAPI(idList,numberOfMealDay,dailyNeed,mealTime);
}
*/
List<int> usedPages=[];
int maxPg=5;
Future<void> getIDsFromAPI(double dailyNeed,String mealTime,int numberOfMealDay,bool isVegan,bool isVegetarian) //tastyfood
async {
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/list";
  final headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': apiKey,
  };
  String tags=mealTime+",healthy"; //healthy ekle ;
  if(isVegan) {
    tags+=",vegan";
  }
  else if(isVegetarian)
  {
    tags+=",vegetarian";
  }

  int rnd=Random().nextInt(maxPg);
  while(usedPages.contains(rnd))
    {
      rnd=Random().nextInt(maxPg);
    }
  usedPages.add(rnd);
  final queryString = {"from":rnd.toString(),"size":"40","tags":tags,"num_servings":"1","nutrition_visibility":"auto"};//,"tags":"under_30_minutes"};//TODO TAKE QUERY
  Uri uri = Uri.https(authority,unencodedPath,queryString);
  http.Response response = await http.get(uri,headers: headers);
  final data=await jsonDecode(response.body);
  double mealCalMax=(12*dailyNeed)/30;
  double mealCalMin=(8*dailyNeed)/30;
  print("count: "+data["count"].toString());
  maxPg=((data["count"]as int)/40).floor();
  int mealCnt=0;
  for(var mealData in data["results"])
    {
      if(mealData["nutrition"]!=null && mealData["nutrition"].length>0 && mealData["nutrition"]["calories"]<=mealCalMax && mealData["nutrition"]["calories"]>=mealCalMin && !foodRecipeRep.containsKey(mealData["name"])) {
        FoodRecipe newFood = FoodRecipe.fromAPI(mealData);
        if(foodRecipeRep.containsKey(newFood.name)) continue;
        foodRecipeRep[newFood.name] = newFood;
        personalMealList[mealTime]!.add(newFood.name);
        mealCnt++;
        print("NEW FOOD ADDED");
        if (mealCnt == numberOfMealDay) return;
      }
    }
  await getIDsFromAPI(dailyNeed,mealTime,numberOfMealDay-mealCnt,isVegan,isVegetarian);
}
/*
Future<void> getInformationsFromAPI(List<int> idList,int numberOfMealDay,double dailyNeed, String mealTime) async { //foodreciperep + personal meal list olusuyo
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/get-more-info";
  const headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': apiKey
  };
  double mealCalMax=(12*dailyNeed)/30;
  double mealCalMin=(8*dailyNeed)/30;
  print("MAX "+mealCalMax.toString());
  print("MIN "+mealCalMin.toString());
  //Map<String,FoodRecipe> mp={};
  int mealCnt=0;
  for(int id in idList)
  {
    //Future.delayed(const Duration(milliseconds: 30));
    final queryString = {"id":id.toString()};
    Uri uri = Uri.https(authority,unencodedPath,queryString);
    http.Response response = await http.get(uri,headers: headers);
    final mealData=await jsonDecode(response.body);
    print("********"+id.toString()+"**********");
    if(mealData["nutrition"].length==0/*||mealData["nutrition"]["calories"]>mealCalMax||mealData["nutrition"]["calories"]<mealCalMin */)
    {
      print("length "+mealData["nutrition"].length.toString()+" "+mealData["nutrition"]["calories"].toString());
      print("CONTINUE");
      continue;
    }
    print("NEW FOOD");
    FoodRecipe newFood=FoodRecipe.fromAPI(mealData);
    foodRecipeRep[newFood.name]=newFood;
    personalMealList[mealTime]!.add(newFood.name);
    mealCnt++;
    print("NEW FOOD ADDED");
    if(mealCnt==numberOfMealDay) break;
  }

  for(var e in foodRecipeRep.keys)
  {
    foodRecipeRep[e]!.printFood();
  }
  print("*********DONE***********");
}
*/