class Ingredient{
  late String name;
  late double amountNum;
  late String amountType;
  late String amountName;

  /*Ingredient(this.name,this.amountNum,this.amountType)
  {
    amountName=amountNum.toString()+" "+amountType+" "+name;
  }*/
  Ingredient({required this.name, required this.amountNum, required this.amountType})
  {
    amountName=amountNum.toString()+" "+amountType+" "+name;
  }
  Ingredient.fromMap(Map<String,dynamic> data)
  {
    name=data["name"];
    amountType=data["amountType"];
    amountNum=data["amountNum"].toDouble();
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

Ingredient sogan=Ingredient(name:"sogan",amountNum:2,amountType: "tane");
Ingredient sarimsak=Ingredient(name: "sarımsak",amountNum: 2,amountType: "tane");
Ingredient yumurta=Ingredient(name: "yumurta",amountNum: 1,amountType: "tane");
Ingredient sut=Ingredient(name: "süt",amountNum: 125 ,amountType: "ml");
Ingredient sivi_yag=Ingredient(name: "sivi_yag",amountNum: 60 ,amountType: "ml");
Ingredient makarna=Ingredient(name: "makarna",amountNum: 2,amountType: "paket");
Ingredient havuc=Ingredient(name: "havuç",amountNum: 1,amountType: "tane");
Ingredient ceviz=Ingredient(name: "ceviz",amountNum: 150,amountType: "gr");
Ingredient vanilya=Ingredient(name: "vanilya",amountNum: 1,amountType: "paket");
Ingredient yogurt=Ingredient(name: "yoğurt",amountNum: 110,amountType: "gr");




List<Ingredient> IngList = [sogan,sarimsak,yumurta];
List<Ingredient> IngList2 = [sogan,sarimsak,makarna];
List<Ingredient> IngList3 = [makarna,yogurt,yumurta];
List<Ingredient> IngList4 = [sogan,vanilya,yumurta,sut];
List<Ingredient> IngList5 = [havuc,sivi_yag,yumurta,ceviz,sut];

