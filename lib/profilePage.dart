import 'dart:ui';

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

  final profileColor = Color(0xff4297a0);
  final backgroundColor = Color(0xfff4eae6);
  final profilePersonColor = Color(0xffffffff);
  final dateColor = Color(0xff41aeba);
  final iconColor = Color(0xffffffff);
  final featureColor = Color(0xffffffff);
  final itemBackgroundColor = Color(0xff9bc0c3);
  final signOutButtonColor = Color(0xffff6b00);
  final signOutTextColor = Color(0xffffffff);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
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
                  "04.03.2022",
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Friday",
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
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));},
              ),
            ),
          ),],
        ),
      ),
      body: ListView(
        children: [
          nameCart(),
          surnameCart(),
          heightCard(),
          weightCard(),
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
  Container nameCart() {
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
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Name",
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
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Container surnameCart() {
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
                  "Surname",
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
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Container heightCard() {
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
                  "Height",
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
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Container weightCard() {
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
                  "Weight",
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
                    ),
                  )
              )
            ],
          ),
        ),
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
}
