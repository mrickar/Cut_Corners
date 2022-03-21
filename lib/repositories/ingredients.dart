String tbsp="tablespoon";
String tsp="teaspoon";
Map<String,double>measurementConvert_gr=
{
  tbsp:13,
  tsp:4,
};
Map<String,double>measurementConvert_ml=
{
  tbsp:15,
  tsp:5,
};

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
    convertType();
    amountName=amountNum.toString()+" "+amountType+" "+name;
  }
  Ingredient.fromMap(Map<String,dynamic> data)
  {
    name=data["name"];
    amountType=data["amountType"];
    amountNum=data["amountNum"].toDouble();
    convertType();
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
  void convertType() {
    if(amountType=="milliliter") {
      amountType="ml";
    }
    else if(amountType=="gram" || amountType=="gr") {
      amountType="g";
    }
    else if(amountType=="liter") {
      amountNum*=1000;
      amountType="ml";
    }
    else if(amountType=="kilograms") {
      amountNum*=1000;
      amountType="g";
    }

    else if(amountType==tsp || amountType==tbsp)
    {
      if(checkLiquid(amountType))
      {
        amountNum*=measurementConvert_ml[amountType]!;
        amountType="ml";
      }
      else
      {
        amountNum*=measurementConvert_gr[amountType]!;
        amountType="gr";
      }
    }
  }
  bool checkLiquid(String amountType)
  {
    List<String> liquids=["oil","water","extract"];
    for(var liq in liquids)
    {
      if(amountType.contains(liq))
      {
        return true;
      }
    }
    return false;
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

