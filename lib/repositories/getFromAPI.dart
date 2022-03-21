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
class FoodRecipeDeneme{
  late List<Ingredient> ingredients=[];
  late String name;
  late int calories;
  late String photoPath;
  String instructions="";
  int? cookTime;
  late Nutrition nutrition;

  FoodRecipeDeneme(this.ingredients,this.name,this.calories,this.photoPath,this.instructions,this.cookTime,this.nutrition);
  FoodRecipeDeneme.fromAPI(Map<String,dynamic> data){
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
  Map<String,dynamic> toMap()
  {
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
  void printFood()
  {
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
*/
Future<void> getIDsFromAPI(double dailyNeed,String mealTime,int numberOfMealDay,bool isVegan,bool isVegetarian) //tastyfood
async {
  //String mealTime="breakfast";//"lunch", "dinner"
  //const KEY="d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f";
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/list";
  //const url = "https://tasty.p.rapidapi.com/recipes/list";
  const headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': "abdfe6c526mshf5c007112e717ddp177098jsna9a7886fd33c"//"d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f"
  };
  String tags=mealTime; //healthy ekle ;
  if(isVegan) {
    tags+=",vegan";
  }
  else if(isVegetarian)
  {
    tags+=",vegetarian";
  }
  final queryString = {"from":Random().nextInt(10).toString(),"size":"100","tags":tags,"num_servings":"1"};//,"tags":"under_30_minutes"};//TODO TAKE QUERY
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

Future<void> getInformationsFromAPI(List<int> idList,int numberOfMealDay,double dailyNeed, String mealTime) async {
  //const KEY="d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f";
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/get-more-info";
  const headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': 'abdfe6c526mshf5c007112e717ddp177098jsna9a7886fd33c'// eski key"d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f"
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
