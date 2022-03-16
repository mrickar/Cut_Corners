import 'dart:convert';
import 'package:http/http.dart' as http;

import 'food_recipe_repository.dart';
import 'ingredients.dart';
Map<String,dynamic> brokenNum= {
  "¼":0.25,
  "Â¼":0.25,
  "¾":0.75,
  "Â¾":0.75,
  "½":0.5,
  "Â½":0.5,
};
class FoodRecipeDeneme{
  late List<Ingredient> ingredients=[];
  late String name;
  late int calories;
  late String photoPath;
  String instructions=""; //TODO madde madde olacak şekilde ayarla
  int? cookTime;
  late Nutrition nutrition;

  FoodRecipeDeneme(this.ingredients,this.name,this.calories,this.photoPath,this.instructions);//TODO YENILERI EKLE
  FoodRecipeDeneme.fromMap(Map<String,dynamic> data)
  {
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
          //TODO int.parse leri double yap ingredient amountu da double yap
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

    return {
      "name":name,
      "calories":calories,
      "photoPath":photoPath,
      "recipe":instructions
    };
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
Future<void> getIDsFromAPI(/*int numberOfMeal*/) //tastyfood
async {
  int numberOfMeal=5;
  const KEY="d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f";
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/list";
  const url = "https://tasty.p.rapidapi.com/recipes/list";
  const headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': "d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f"
  };
  final querystring = {"from":"0","size":numberOfMeal.toString(),"tags":"under_30_minutes"};//TODO TAKE QUERY
  Uri uri = Uri.https(authority,unencodedPath,querystring);
  http.Response response = await http.get(uri,headers: headers);
  final data=await jsonDecode(response.body);
  List<int> idList=[];
  Map<String,FoodRecipeDeneme> mp={};
  for(var element in data["results"])
  {
    idList.add(element["id"]);
  }
  getInformationsFromAPI(idList);
}

Future<void> getInformationsFromAPI(List<int> idList) async {
  const KEY="d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f";
  String authority="tasty.p.rapidapi.com";
  String unencodedPath="/recipes/get-more-info";
  const headers = {
    'x-rapidapi-host': "tasty.p.rapidapi.com",
    'x-rapidapi-key': "d135548dcemsh6edfdd094aa92e5p161a39jsn496fd28b501f"
  };
  Map<String,FoodRecipeDeneme> mp={};
  for(int id in idList)
  {
    Future.delayed(const Duration(milliseconds: 30));
    final querystring = {"id":id.toString()};
    Uri uri = Uri.https(authority,unencodedPath,querystring);
    http.Response response = await http.get(uri,headers: headers);
    final mealData=await jsonDecode(response.body);
    print("********"+id.toString()+"**********");
    if(mealData["nutrition"].length==0)
    {
      print("CONTINUE");
      continue;
    }
    print("NEW FOOD");
    FoodRecipeDeneme newFood=FoodRecipeDeneme.fromMap(mealData);
    mp[newFood.name]=newFood;
    print("NEW FOOD ADDED");
  }

  for(var e in mp.keys)
  {
    mp[e]!.printFood();
  }
  print("*********DONE***********");
}