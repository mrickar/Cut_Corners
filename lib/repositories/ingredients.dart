String tbsp="tablespoon";
String tsp="teaspoon";
Map<String,double>measurementConvert_gr=
{
  "ounce":28,
  tbsp:13,
  tsp:4,
};
Map<String,double>measurementConvert_ml=
{
  "ounce":30,
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
    else if(amountType=="kilograms" ||amountType=="kilogram" ) {
      amountNum*=1000;
      amountType="g";
    }

    else if(amountType==tsp || amountType==tbsp || amountType=="ounce")
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
    List<String> liquids=["oil","water","extract","vinegar"];
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
