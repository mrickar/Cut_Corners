import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/googleSign.dart';

class ProfileInfo{
  //late String email;
  late String name;
  late String surname;
  late String gender;
  late int height;
  late int weight;
  late int dailyActivity;
  late int age;
  late double dailyCal;

  ProfileInfo(this.name,this.surname,this.gender,this.height,this.weight,this.dailyActivity,this.age)
  {
     dailyCal=calculateDailyCaloryNeed(weight,height,age,dailyActivity,gender);
  }
  ProfileInfo.fromMap(Map <String,dynamic> data)
  {
    name=data["name"];
    surname=data["surname"];
    gender=data["gender"];
    height=data["height"];
    weight=data["weight"];
    dailyActivity=data["dailyActivity"];
    age=data["age"];
   dailyCal=calculateDailyCaloryNeed(weight,height,age,dailyActivity,gender);
  }
Map<String,dynamic> toMap()
{
  Map<String,dynamic> data={
    "name":name,
    "surname":surname,
    "gender":gender,
    "height":height,
    "weight":weight,
    "dailyActivity":dailyActivity,
    "age":age
  };
  return data;
}

  void printInfo()
  {
    print("name: "+name);
    print("surname: "+surname);
    print("gender: "+gender);
    print("height: "+height.toString());
    print("weight: "+weight.toString());
    print("gender: "+gender);
    print("dailyActivity: "+dailyActivity.toString());

  }
}
late ProfileInfo USER;
void getUser()
async {
  DocumentSnapshot<Map<String, dynamic>> snapshot =  await FirebaseFirestore.instance.collection("Profiles").doc(getUid()).get();
  USER =ProfileInfo.fromMap(snapshot.data()!);
  return;
}
double calculateDailyCaloryNeed(int weight,int height,int age,int dailyAct,String gender)
{
  if(gender=="Male")
    {
      return (10*weight+6.25*height-5*age+5)*(1.025+dailyAct*0.175);
    }
  else if(gender=="Female")
    {
      return 10*weight+6.25*height-5*age-161*(1.025+dailyAct*0.175);
    }
  else
    {
      return 10*weight+6.25*height-5*age-161*(1.025+dailyAct*0.175);
    }
}
