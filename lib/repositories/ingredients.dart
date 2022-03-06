const ml="ml";
const gr="gr";
class Ingredient{
  //late String pathOfItem;
  late String name;
  late int amount;
  late String amountType;
  late bool isDrink;

  Ingredient(this.name,this.amount,this.amountType,this.isDrink);
}
class IngredientRepository
{
  /*Ingredient sogan=Ingredient("sogan",2,"tane",false);
  Ingredient sarimsak=Ingredient("sarımsak",2,"tane",false);
  Ingredient yumurta=Ingredient("yumurta",1,"tane",false);*/
  List<Ingredient> IngList=[Ingredient("sogan",2,"tane",false),Ingredient("sarımsak",2,"tane",false),Ingredient("yumurta",1,"tane",false)];
}