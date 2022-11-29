// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/home.dart';
import 'package:flutter_application_1/windows/screen.dart';
import 'package:flutter_application_1/windows/Auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async {
   void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  
  initFirebase();
 runApp(MaterialApp(
  theme: ThemeData(primaryColor: Colors.black45),

  initialRoute: '/screen',
  routes: {
    '/': (context) => Authc(),
    '/screen': (context) => MyApp(),

   

  },
 ));
}
