import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/windows/pages/screen.dart';
import 'package:flutter_application_1/windows/pages/screen.dart';
import 'package:flutter_application_1/windows/Auth/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context){
  final bool isLoggedIn = false;
  
  return isLoggedIn ? Screen() : Authc();
}
}