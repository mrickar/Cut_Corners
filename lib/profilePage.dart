import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:cut_corners/repositories/profileInformation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

bool isClickedName=false;
bool isClickedSurname=false;
bool isClickedHeight=false;
bool isClickedWeight=false;
bool isClickedGender=false;
bool isClickedDailyAct=false;
Color itemBackgroundColor=Colors.blue.shade400;
class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);
  final _controllerTextEditName=TextEditingController(text:USER.name);
   final _controllerTextEditSurname=TextEditingController(text:USER.surname);
   final _controllerTextEditHeight=TextEditingController(text:USER.height.toString());
   final _controllerTextEditWeight=TextEditingController(text:USER.weight.toString());
   final _nameFormState=GlobalKey<FormFieldState>();
   final _surnameFormState=GlobalKey<FormFieldState>();
   final _heightFormState=GlobalKey<FormFieldState>();
   final _weightFormState=GlobalKey<FormFieldState>();
   final _genderFormState=GlobalKey<FormFieldState>();
   final _activityFormState=GlobalKey<FormFieldState>();
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String curUid=getUid();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: ListView(
        children: [
          nameCart(),
          surnameCart(),
          heightCard(),
          weightCard(),
          genderCard(),
          dailyActCard(),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color:Colors.amber,
              ),
              child: TextButton(
                onPressed: ()
                {
                  signOutwitGoogle();
                  SystemNavigator.pop();
                  },
                child: const Text("SIGN OUT"),
              ),
            ),
          ),
        ],

      ),
    );
  }
  Padding nameCart() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color:itemBackgroundColor,
        ),
        child: Stack(
          children: [
            const Text("Name"),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 40,
                onPressed:() {
                  setState(() {
                    if(isClickedName)
                    {
                      if(widget._nameFormState.currentState!.validate())
                      {
                        USER.name=widget._controllerTextEditName.value.text;
                        FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"name":USER.name});
                      }
                      else
                      {
                        return;
                      }
                    }
                    isClickedName=!isClickedName;
                  });

                },
                icon: isClickedName? const Icon(Icons.save):const Icon(Icons.edit),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 70,
                  width: 250,
                  child: TextFormField(
                    key: widget._nameFormState,
                    controller: widget._controllerTextEditName,
                    enabled: isClickedName,
                    decoration: InputDecoration(
                      border: isClickedName?const OutlineInputBorder():InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Padding surnameCart() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color:itemBackgroundColor,
        ),
        child: Stack(
          children: [
            const Text("Surname"),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 40,
                onPressed:() {
                  setState(() {
                    if(isClickedSurname)
                    {
                      if(widget._surnameFormState.currentState!.validate())
                      {
                        USER.surname=widget._controllerTextEditSurname.value.text;
                        FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"surname":USER.surname});
                      }
                      else
                      {
                        return;
                      }
                    }
                    isClickedSurname=!isClickedSurname;
                  });

                },
                icon: isClickedSurname? const Icon(Icons.save):const Icon(Icons.edit),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 70,
                  width: 250,
                  child: TextFormField(
                    key: widget._surnameFormState,
                    controller: widget._controllerTextEditSurname,
                    enabled:isClickedSurname ,
                    decoration: InputDecoration(
                      border: isClickedSurname?const OutlineInputBorder():InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your surname';
                      }
                      return null;
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Padding heightCard() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color:itemBackgroundColor,
        ),
        child: Stack(
          children: [
            const Text("Height"),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  setState(() {
                    if(isClickedHeight)
                    {
                      if(widget._heightFormState.currentState!.validate())
                        {
                          USER.height=int.parse(widget._controllerTextEditHeight.value.text);
                          FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"height":USER.height});
                        }
                      else
                        {
                          return;
                        }
                    }
                    isClickedHeight=!isClickedHeight;
                  });
                },
                icon: isClickedHeight? const Icon(Icons.save):const Icon(Icons.edit),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 70,
                  width: 250,
                  child: TextFormField(
                    key: widget._heightFormState,
                    keyboardType: TextInputType.number,
                    controller: widget._controllerTextEditHeight,
                    enabled: isClickedHeight,
                      decoration: InputDecoration(
                        border: isClickedHeight?const OutlineInputBorder():InputBorder.none,
                      ),
                    validator: (value) {
                      int height=int.parse(value!);
                      if (value.isEmpty) {
                        return 'Please enter your height';
                      }
                      if(30>=height ||height>=250)
                        {
                          return 'Your height must be between 30-250.';
                        }
                      return null;
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Padding weightCard() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color:itemBackgroundColor,
        ),
        child: Stack(
          children: [
            const Text("Weight"),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 40,
                onPressed:() {
                  setState(() {
                    if(isClickedWeight)
                    {
                      if(widget._weightFormState.currentState!.validate())
                      {
                        USER.weight=int.parse(widget._controllerTextEditWeight.value.text);
                        FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"weight":USER.weight});
                      }
                      else
                      {
                        return;
                      }
                    }
                    isClickedWeight=!isClickedWeight;
                  });

                },
                icon: isClickedWeight? const Icon(Icons.save):const Icon(Icons.edit),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 70,
                  width: 250,
                  child: TextFormField(
                    key: widget._weightFormState,
                    keyboardType: TextInputType.number,
                    controller: widget._controllerTextEditWeight,
                    enabled: isClickedWeight,
                    decoration: InputDecoration(
                      border: isClickedWeight?const OutlineInputBorder():InputBorder.none,
                    ),
                    validator: (value) {
                      int weight=int.parse(value!);
                      if (value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      if(0>=weight)
                      {
                        return 'Your weight must be bigger than 0.';
                      }
                      return null;
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Padding genderCard() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color:itemBackgroundColor,
        ),
        child: Stack(
          children: [
            const Text("Gender"),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 40,
                onPressed:() {
                  setState(() {
                    if(isClickedGender)
                    {
                      widget._genderFormState.currentState!.save();
                    }
                    isClickedGender=!isClickedGender;
                  });

                },
                icon: isClickedGender? const Icon(Icons.save):const Icon(Icons.edit),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 70,
                  width: 250,
                  child: DropdownButtonFormField<String>(
                    key:widget._genderFormState,
                    value: USER.gender,
                    onChanged:isClickedGender? (value) {
                    }:null,
                    onSaved:(value){
                      setState(() {
                        USER.gender=value!;
                        FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"gender":USER.gender});
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        child:Text("Male"),
                        value: "Male",
                      ),
                      DropdownMenuItem(
                        child:Text("Female"),
                        value: "Female",
                      ),
                      DropdownMenuItem(
                        child:Text("Other"),
                        value: "Other",
                      ),
                    ],
                    //initialValue: person1.name,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Padding dailyActCard() {
    return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color:itemBackgroundColor,
            ),
            child: Stack(
              children: [
                const Text("Daily Activity"),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 40,
                    onPressed:() {
                      setState(() {
                        if(isClickedDailyAct)
                        {
                          widget._activityFormState.currentState!.save();
                        }
                        isClickedDailyAct=!isClickedDailyAct;
                      });

                    },
                    icon: isClickedDailyAct? const Icon(Icons.save):const Icon(Icons.edit),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 70,
                      width: 250,
                      child: DropdownButtonFormField<int>(
                        key:widget._activityFormState,
                        value: USER.dailyActivity,
                        onChanged:isClickedDailyAct? (value) {
                        }:null,
                        onSaved:(value){
                          setState(() {
                            FirebaseFirestore.instance.collection("Profiles").doc(curUid).update({"dailyActivity":USER.dailyActivity});
                            USER.dailyActivity=value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            child:Text("1"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child:Text("2"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child:Text("3"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child:Text("4"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child:Text("5"),
                            value: 5,
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        );
  }











}
