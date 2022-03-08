const ml="ml";
const gr="gr";
class Ingredient{
  //late String pathOfItem;
  late String name;
  late int amountNum;
  late String amountType;
  late String amount;
  //late bool isDrink;

  Ingredient(this.name,this.amountNum,this.amountType)
  {
    amount=amountNum.toString()+" "+amountType;
  }
  Ingredient.fromMap(Map<String,dynamic> data)
  {
    name=data["name"];
    amountType=data["amountType"];
    amountNum=data["amountNum"];
    amount=amountNum.toString()+" "+amountType;
  }
  Map<String,dynamic> toMap()
  {
    return {
      "name":name,
      "amountNum":amountNum,
      "amountType":amountType
    };
  }
}
class IngredientRepository {
  /*Ingredient sogan=Ingredient("sogan",2,"tane",false);
  Ingredient sarimsak=Ingredient("sarımsak",2,"tane",false);
  Ingredient yumurta=Ingredient("yumurta",1,"tane",false);*/
  List<Ingredient> IngList = [
    Ingredient("sogan", 100, "gr"),
    Ingredient("sarımsak", 2, "tane"),
    Ingredient("yumurta", 1, "tane")
  ];
}