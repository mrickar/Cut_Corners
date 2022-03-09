const ml="ml";
const gr="gr";
class Ingredient{
  late String name;
  late int amountNum;
  late String amountType;
  late String amountName;

  /*Ingredient(this.name,this.amountNum,this.amountType)
  {
    amountName=amountNum.toString()+" "+amountType+" "+name;
  }*/
  Ingredient({required this.name, required this.amountNum, required this.amountType});
  Ingredient.fromMap(Map<String,dynamic> data)
  {
    name=data["name"];
    amountType=data["amountType"];
    amountNum=data["amountNum"];
    amountName=amountNum.toString()+" "+amountType+" "+name;
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
  /*List<Ingredient> IngList = [
    Ingredient("sogan", 100, "gr"),
    Ingredient("sarımsak", 2, "tane"),
    Ingredient("yumurta", 1, "tane")
  ];*/
}