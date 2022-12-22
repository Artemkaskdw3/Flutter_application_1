import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/windows/Auth/services/user.dart';
import 'package:flutter_application_1/windows/pages/screen.dart';
import 'package:flutter_application_1/windows/Auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context){
     final AuthUser? user = Provider.of<AuthUser?>(context);
    final bool isLoggedIn = user !=null;
  
  return isLoggedIn ? Screen() : Authc();
}
}