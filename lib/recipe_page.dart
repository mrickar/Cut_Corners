import 'package:cut_corners/repositories/food_recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class colorChangeforPage extends ChangeNotifier
{
  int colorIndex=0;
  List<Color> colors=[Colors.black,Colors.white];

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
  @override
  void initState() {
    super.initState();
    //pageController = PageController();
  }
  @override
  Widget build(BuildContext context) {
    final recipeOfFood=foodRecipeRep[widget.foodName];
    final colorProv = ref.watch(colorChangeforPageProvider);
    return Scaffold(
          backgroundColor: Colors.grey.shade400,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75,bottom: 25,left: 25),
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child:Image.asset(
                      recipeOfFood!.photoPath!=null? recipeOfFood.photoPath!:"TODO",//TODO
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhysicalModel(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(recipeOfFood.name+"\n("+recipeOfFood.calories.toString()+" cal)"),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 400,
                  height: 300,
                  child: PhysicalModel(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
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
                                    ListView.builder(
                                      itemCount: recipeOfFood.ingredients.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        //todo Bullet koy başına
                                        String ingItem=recipeOfFood.ingredients[index].amountName;
                                        return Text(ingItem);
                                      },
                                    ),
                                    SingleChildScrollView(
                                      child: Text(recipeOfFood.instructions),
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
                                        color: colorProv.colors[colorProv.colorIndex],
                                        border: Border.all(color: Colors.black)
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
                                      color: colorProv.colors[1-colorProv.colorIndex],
                                      border: Border.all(color: Colors.black)
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
