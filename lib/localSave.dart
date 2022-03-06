//create JSON
import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory!.path;
}
Future<File> get _dbFile async {
  final path = await _localPath;
  return new File("$path/demo.json");
}
/*
Future<void> write(DataSnapshot snapshot,String chatId) async {
  final path = await _dbFile;
  final String? key = snapshot.key;
  final String name = snapshot.value()['senderUid'];
  final int age= snapshot.value['receivedUid'];
  String content = '{"$key":{"name":"$name","age":"$age"}}';
  final File file = File("result.csv");
  return file.writeAsStringSync(content);
  //return await file.writeAsStringSync(content);
}
*/
Future<Null> read() async {
  try {
    final file = await _dbFile;
    String content = file.readAsStringSync();
    Map<String, dynamic> chatMap=json.decode(content);
    chatMap.keys.forEach((E){debugPrint(E);});
  } catch (e) {
    debugPrint('Error : '+e.toString());
  }
}