import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_corners/repositories/profileInformation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

bool isClickedName=false;
bool isClickedSurname=false;
bool isClickedHeight=false;
bool isClickedWeight=false;
bool isClickedGender=false;
bool isClickedDailyAct=false;
Color itemBackgroundColor=Colors.blue.shade400;
class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);
  final _controllerTextEditName=TextEditingController(text:person1.name);
   final _controllerTextEditSurname=TextEditingController(text:person1.surname);
   final _controllerTextEditHeight=TextEditingController(text:person1.height.toString());
   final _controllerTextEditWeight=TextEditingController(text:person1.weight.toString());
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
                onPressed: () { person1.printInfo(); },
                child: const Text("SHOW"),
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
                        person1.name=widget._controllerTextEditName.value.text;
                        FirebaseFirestore.instance.collection("Profiles").doc(person1.email).update({"name":person1.name});
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
                        person1.surname=widget._controllerTextEditSurname.value.text;
                        FirebaseFirestore.instance.collection("Profiles").doc(person1.email).update({"surname":person1.surname});
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
                          person1.height=int.parse(widget._controllerTextEditHeight.value.text);
                          FirebaseFirestore.instance.collection("Profiles").doc(person1.email).update({"height":person1.height});
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
                        person1.weight=int.parse(widget._controllerTextEditWeight.value.text);
                        FirebaseFirestore.instance.collection("Profiles").doc(person1.email).update({"weight":person1.weight});
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
                    value: person1.gender,
                    onChanged:isClickedGender? (value) {
                    }:null,
                    onSaved:(value){
                      setState(() {
                        person1.gender=value!;
                        FirebaseFirestore.instance.collection("Profiles").doc(person1.email).update({"gender":person1.gender});
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        child:Text("MAN"),
                        value: "MAN",
                      ),
                      DropdownMenuItem(
                        child:Text("WOMAN"),
                        value: "WOMAN",
                      ),
                      DropdownMenuItem(
                        child:Text("OTHER"),
                        value: "OTHER",
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
                        value: person1.dailyActivity,
                        onChanged:isClickedDailyAct? (value) {
                        }:null,
                        onSaved:(value){
                          setState(() {
                            FirebaseFirestore.instance.collection("Profiles").doc(person1.email).update({"dailyActivity":person1.dailyActivity});
                            person1.dailyActivity=value!;
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
