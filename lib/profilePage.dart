import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/profileInformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


var now = DateTime.now();
var formatter = DateFormat('yyyy.MM.dd');
String formattedDate = formatter.format(now);
String weekDay = DateFormat('EEEE').format(now);

Map<String,bool> isClicked={
  "name":false,
  "surname":false,
  "height":false,
  "weight":false,
  "gender":false,
  "dailyActivity":false,
  "age":false
};
Map<String,TextEditingController> controllerTextEditMap={
  "name":TextEditingController(text:USER.name),
  "surname":TextEditingController(text:USER.surname),
  "height":TextEditingController(text:USER.height.toString()),
  "weight":TextEditingController(text:USER.weight.toString()),
  "age":TextEditingController(text:USER.age.toString())
};
Map<String,GlobalKey<FormFieldState>> formStateMap={
  "name":GlobalKey<FormFieldState>(),
  "surname":GlobalKey<FormFieldState>(),
  "height":GlobalKey<FormFieldState>(),
  "weight":GlobalKey<FormFieldState>(),
  "age":GlobalKey<FormFieldState>(),
  "gender":GlobalKey<FormFieldState>(),
  "dailyActivity":GlobalKey<FormFieldState>()
};
/*
bool isClickedName=false;
bool isClickedSurname=false;
bool isClickedHeight=false;
bool isClickedWeight=false;
bool isClickedGender=false;
bool isClickedDailyAct=false;
bool isClickedAge=false;
*/
class ProfilePage extends StatefulWidget {
   const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String curUid=getUid();

  final profileColor = const Color(0xff4297a0);
  final backgroundColor = const Color(0xfff4eae6);
  final profilePersonColor = const Color(0xffffffff);
  final dateColor = const Color(0xff41aeba);
  final iconColor = const Color(0xffffffff);
  final featureColor = const Color(0xffffffff);
  final itemBackgroundColor = const Color(0xff9bc0c3);
  final signOutButtonColor = const Color(0xffff6b00);
  final signOutTextColor = const Color(0xffffffff);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  weekDay,
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: profileColor,
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: profilePersonColor,
                  size: 24.0,
                ),
                onPressed: () {},
              ),
            ),
          ),],
        ),
      ),
      body: ListView(
        children: [
          textFieldCart("name"),
          textFieldCart("surname"),
          textFieldCart("age"),
          textFieldCart("height"),
          textFieldCart("weight"),
          genderCard(),
          dailyActCard(),
          Container(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    color: signOutButtonColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(10.0)),
                  ),
                  child: TextButton(
                    onPressed: ()
                    {
                      signOutwitGoogle();
                      SystemNavigator.pop();
                      },
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: signOutTextColor,
                        fontSize: 14.0,
                        fontFamily: 'Krona One',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
  Container genderCard() {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color:itemBackgroundColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Gender",
                  style: TextStyle(
                    fontFamily: 'Lexend Peta',
                    fontWeight: FontWeight.w400,
                    color: featureColor,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 35,
                  color: iconColor,
                  onPressed:() {
                    setState(() {
                      if(isClicked["gender"]!)
                      {
                        formStateMap["gender"]!.currentState!.save();
                      }
                      isClicked["gender"]=!isClicked["gender"]!;
                    });

                  },
                  icon: isClicked["gender"]!? const Icon(Icons.save):const Icon(Icons.edit),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: SizedBox(
                      height: 70,
                      width: 250,
                      child: DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontFamily: 'Lexend Peta',
                          fontWeight: FontWeight.w400,
                          color: featureColor,
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: itemBackgroundColor),
                            ),
                        ),
                        dropdownColor: itemBackgroundColor,
                        key:formStateMap["gender"]!,
                        value: USER.gender,
                        onChanged:isClicked["gender"]!? (value) {
                        }:null,
                        onSaved:(value){
                          setState(() {
                            USER.gender=value!;
                            FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"gender":USER.gender});
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(
                                "Male",
                              style: TextStyle(
                                color: featureColor,
                              ),
                            ),
                            value: "Male",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Female",
                              style: TextStyle(
                                color: featureColor,
                              ),
                            ),
                            value: "Female",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Other",
                              style: TextStyle(
                                color: featureColor,
                              ),
                            ),
                            value: "Other",
                          ),
                        ],
                        //initialValue: person1.name,
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Container dailyActCard() {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color:itemBackgroundColor,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Daily Activity",
                      style: TextStyle(
                        fontFamily: 'Lexend Peta',
                        fontWeight: FontWeight.w400,
                        color: featureColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      iconSize: 35,
                      color: iconColor,
                      onPressed:() {
                        setState(() {
                          if(isClicked["dailyActivity"]!)
                          {
                            formStateMap["dailyActivity"]!.currentState!.save();
                          }
                          isClicked["dailyActivity"]=!isClicked["dailyActivity"]!;
                        });

                      },
                      icon: isClicked["dailyActivity"]!? const Icon(Icons.save):const Icon(Icons.edit),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: SizedBox(
                          height: 70,
                          width: 250,
                          child: DropdownButtonFormField<int>(
                            style: TextStyle(
                              fontFamily: 'Lexend Peta',
                              fontWeight: FontWeight.w400,
                              color: featureColor,
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: itemBackgroundColor),
                              ),
                            ),
                            dropdownColor: itemBackgroundColor,
                            key:formStateMap["dailyActivity"]!,
                            value: USER.dailyActivity,
                            onChanged:isClicked["dailyActivity"]!? (value) {
                            }:null,
                            onSaved:(value){
                              setState(() {
                                USER.dailyActivity=value!;
                                FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"dailyActivity":USER.dailyActivity});
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                    "1",
                                    style: TextStyle(
                                      color: featureColor,
                                    ),
                                ),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                    color: featureColor,
                                  ),
                                ),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                    color: featureColor,
                                  ),
                                ),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "4",
                                  style: TextStyle(
                                    color: featureColor,
                                  ),
                                ),
                                value: 4,
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                    color: featureColor,
                                  ),
                                ),
                                value: 5,
                              ),
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
    );
  }
  void changeValue(String question) {
    if(isClicked[question]!) {
      if (formStateMap[question]!.currentState!.validate()) {
        if (question == "name") {
          USER.name = controllerTextEditMap[question]!.value.text;
          FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({question: USER.name});
        }
        else if (question == "surname") {
          USER.surname = controllerTextEditMap[question]!.value.text;
          FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({question: USER.surname});
        }
        else if (question == "weight") {
          USER.weight = int.parse(controllerTextEditMap[question]!.value.text);
          FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({question: USER.weight});
        }
        else if (question == "height") {
          USER.height = int.parse(controllerTextEditMap[question]!.value.text);
          FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({question: USER.height});
        }
        else if (question == "age") {
          USER.age = int.parse(controllerTextEditMap[question]!.value.text);
          FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({question: USER.age});
        }
      }
      else {
          return;
        }
    }
    isClicked[question]=!isClicked[question]!;

  }
  String? validateCheck(String question, String? value) {
    if (question == "name") {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    }
    else if (question == "surname") {
      if (value == null || value.isEmpty) {
        return 'Please enter your surname';
      }
      return null;
    }
    else if (question == "weight") {
      int weight=int.parse(value!);
      if (value.isEmpty) {
        return 'Please enter your weight';
      }
      if(0>=weight)
      {
        return 'Your weight must be bigger than 0.';
      }
      return null;
    }
    else if (question == "height") {
      int height=int.parse(value!);
      if (value.isEmpty) {
        return 'Please enter your height';
      }
      if(30>=height ||height>=250)
      {
        return 'Your height must be between 30-250.';
      }
      return null;
    }
    else if (question == "age") {
      int height=int.parse(value!);
      if (value.isEmpty) {
        return 'Please enter your age';
      }
      if(5>=height ||height>=120)
      {
        return 'Your height must be between 5-120.';
      }
      return null;
    }
    return null;
  }
  Container textFieldCart(String question) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color:itemBackgroundColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question,
                  style: TextStyle(
                    fontFamily: 'Lexend Peta',
                    fontWeight: FontWeight.w400,
                    color: featureColor,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 35,
                  color: iconColor,
                  onPressed:() {
                    setState(() {
                      changeValue(question);
                    });
                  },
                  icon: isClicked[question]!? const Icon(Icons.save):const Icon(Icons.edit),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: SizedBox(
                      height: 70,
                      width: 250,
                      child: TextFormField(
                        style: TextStyle(
                          fontFamily: 'Lexend Peta',
                          fontWeight: FontWeight.w400,
                          color: featureColor,
                          fontSize: 18.0,
                        ),
                        key: formStateMap[question],
                        controller: controllerTextEditMap[question],
                        keyboardType: question=="name" || question=="surname"?null:TextInputType.number,
                        enabled: isClicked[question],
                        decoration: InputDecoration(
                          border: isClicked[question]!?const OutlineInputBorder():InputBorder.none,
                        ),
                        validator: (value) {
                          return validateCheck(question,value);
                        },
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}



