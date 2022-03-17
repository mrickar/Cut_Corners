import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> signOutwitGoogle() async {
  await FirebaseAuth.instance.signOut();
  GoogleSignIn().signOut();
}
Future<bool> isExists()
async {
 // return FirebaseAuth.instance.currentUser!=null;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var doc = await FirebaseFirestore.instance.collection("Profiles").doc(uid).get();
  return doc.exists;
}

void saveUser(Map<String,dynamic> data)
{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  data["mealListCreated"]=DateTime.now();
  FirebaseFirestore.instance.collection("Profiles").doc(uid).set(data);
}

String getUid()
{
  return FirebaseAuth.instance.currentUser!.uid;
}