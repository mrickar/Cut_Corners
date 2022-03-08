import 'package:cut_corners/main.dart';
import 'package:cut_corners/questionnaire.dart';
import 'package:cut_corners/repositories/googleSign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isFirebaseInit=false;
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child: isFirebaseInit?
          ElevatedButton(onPressed: () async {
            await signInWithGoogle();
            //bool isExistsCheck=await isExists();
              await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Questionnaire(),));
          },
              child: const Text("Sign In with Google"))
              :const CircularProgressIndicator()),
    );
  }
  Future<void> initializeFirebase() async{
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInit=true;
    });
    bool isExistsCheck=await isExists();
    setState(() {
      if(isExistsCheck)
      {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),));
      }
    });
  }
}
