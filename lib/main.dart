// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/Auth/landing.dart';
import 'package:flutter_application_1/windows/Auth/services/authSERVICES.dart';
import 'package:flutter_application_1/windows/home.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';
import 'package:flutter_application_1/windows/pages/screen.dart';
import 'package:flutter_application_1/windows/Auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'windows/Auth/services/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      value: AuthService().currentUser,
      child: MaterialApp(
        home: LandingPage(),
      ),
      initialData: null,
    );
  }
}
