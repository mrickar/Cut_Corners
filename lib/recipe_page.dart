import 'dart:ui';

import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class colorChangeforPage extends ChangeNotifier
{
  int colorIndex=0;
  List<Color> colors=[Color(0xff595959),Colors.white];

  void colorChange(int value)
  {
    colorIndex=value;
    notifyListeners();
  }
  @override
  void dispose() {
    colorIndex=0;
    super.dispose();
  }

}
final colorChangeforPageProvider =ChangeNotifierProvider.autoDispose((ref) => colorChangeforPage(),);
final basicProv=Provider((ref) {
  int colorInd=0;
  return colorInd;
},);
class RecipePage extends ConsumerStatefulWidget {
  RecipePage({Key? key, required this.foodName}) : super(key: key);
  final String foodName;
  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  final PageController pageController=PageController();

  final backgroundColor = Color(0xfff4eae6);
  final mealNameBackground = Color(0xfff7ac32);
  final mealNameTextColor = Color(0xffffffff);
  final ingredientsBackground = Color(0xff9bc0c3);
  final ingredientsTextColor = Color(0xff595959);

  @override
  void initState() {
    super.initState();
    //pageController = PageController();
  }
  @override
  Widget build(BuildContext context) {
    final recipeOfFood=foodRecipeRep[widget.foodName];
    final colorProv = ref.watch(colorChangeforPageProvider);
    var nutMap = recipeOfFood!.nutrition.toMap();
    return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: backgroundColor,
              elevation: 0.0,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
          ),
          backgroundColor: backgroundColor,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(75)),
                    child:recipeOfFood.photoPath!=null?Image.network(recipeOfFood.photoPath!,fit: BoxFit.fill):const Text("No Photo"),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: mealNameBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                              recipeOfFood.name,
                              style: TextStyle(
                                fontFamily: 'Lexend Peta',
                                fontWeight: FontWeight.w400,
                                color: mealNameTextColor,
                              ),
                          ),
                          const SizedBox(height: 4.0,),
                          Text(
                              "("+recipeOfFood.calories.toString()+" cal)",
                              style: TextStyle(
                                  fontFamily: 'Lexend Peta',
                                  fontWeight: FontWeight.w400,
                                  color: mealNameTextColor,
                              ),
                          ),
                        ],
                      ),
                      //child: Text(recipeOfFood.name+"\n("+recipeOfFood.calories.toString()+" cal)"),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 360,
                  height: 300,
                  child: PhysicalModel(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: ingredientsBackground,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children:[
                              SizedBox(
                                height: 274,
                                width: 300,
                                child: PageView(
                                  onPageChanged:(value) {
                                    colorProv.colorChange(value);
                                  },
                                  controller: pageController,
                                  children:[
                                    Column(
                                      children: [
                                         SizedBox(
                                          height: 30,
                                            width: 300,
                                            child: Text(
                                                "Ingredients",
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Peta',
                                                  fontWeight: FontWeight.w400,
                                                  color: ingredientsTextColor,
                                                ),
                                            )
                                        ),
                                        SizedBox(
                                          height: 244,
                                          width: 300,
                                          child: ListView.builder(
                                            itemCount: recipeOfFood.cookTime!=null?recipeOfFood.ingredients.length+1:recipeOfFood.ingredients.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              if(index==0&&recipeOfFood.cookTime!=null)
                                                {
                                                  return Text(
                                                      recipeOfFood.cookTime.toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'Lexend Peta',
                                                        fontWeight: FontWeight.w400,
                                                        color: ingredientsTextColor,
                                                      ),
                                                  );
                                                }
                                              String ingItem=recipeOfFood.ingredients[index].amountName;
                                              return Text(
                                                  '- ' + ingItem,
                                                  style: TextStyle(
                                                    fontFamily: 'Lexend Peta',
                                                    fontWeight: FontWeight.w400,
                                                    color: ingredientsTextColor,
                                                  ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                            height: 30,
                                            width: 300,
                                            child: Text(
                                                "Instructions",
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Peta',
                                                  fontWeight: FontWeight.w400,
                                                  color: ingredientsTextColor,
                                                ),
                                            )
                                        ),
                                        SizedBox(
                                          height: 244,
                                          width: 300,
                                          child: SingleChildScrollView(
                                            child: Text(
                                                recipeOfFood.instructions,
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Peta',
                                                  fontWeight: FontWeight.w400,
                                                  color: ingredientsTextColor,
                                                ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                Column(
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        width: 300,
                                        child: Text(
                                            "Nutrition",
                                            style: TextStyle(
                                              fontFamily: 'Lexend Peta',
                                              fontWeight: FontWeight.w400,
                                              color: ingredientsTextColor,
                                            ),
                                        )
                                    ),
                                    SizedBox(
                                      height: 244,
                                      width: 300,
                                      child: ListView.builder(
                                        itemCount:6,//number of nutrition type,
                                        itemBuilder: (BuildContext context, int index) {
                                          var nutType = nutMap.keys.elementAt(index);
                                          var nutAmount = nutMap.values.elementAt(index).toString();
                                          String nutItem=nutType+" : "+nutAmount;
                                          return Text(
                                              nutItem,
                                              style: TextStyle(
                                                fontFamily: 'Lexend Peta',
                                                fontWeight: FontWeight.w400,
                                                color: ingredientsTextColor,
                                              ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorProv.colorIndex==0?colorProv.colors[0]:colorProv.colors[1],
                                        border: Border.all(color: Color(0xff595959))
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorProv.colorIndex==1?colorProv.colors[0]:colorProv.colors[1],
                                      border: Border.all(color: Color(0xff595959))
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorProv.colorIndex==2?colorProv.colors[0]:colorProv.colors[1],
                                        border: Border.all(color: Color(0xff595959))
                                    ),
                                  ),
                                ],
                              ),
                            ]
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

  }
}
