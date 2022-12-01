// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/home.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';
import 'package:flutter_application_1/windows/pages/screen.dart';
import 'package:flutter_application_1/windows/Auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async {
   void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  
  initFirebase();
 runApp(MaterialApp(home: MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
         body: Center(child: ElevatedButton(onPressed: () {
           Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Screen(),
                                  ));
                                  
         },
         child: Text("sd"),
         )),
    );
  }
  }