import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authc extends StatefulWidget {
  const Authc({super.key});

  @override
  State<Authc> createState() => _AuthcState();
}

class _AuthcState extends State<Authc> {
  TextEditingController _loginContller = TextEditingController();
  TextEditingController _passwordContller = TextEditingController();

  String _login ='';
  String _password='';
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
            child: Align(
              child: Text(
                'ZaEdy',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ));
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(top: 30,left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(
            fontSize: 20,
            ),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 20, color: Colors.black45),
              hintText: hint,
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(width: 3)),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.black),
                  child: icon,
                ),
              )),
        ),
      );
    }

    Widget _button (String text, void func()){
      return ElevatedButton(
        onPressed: () {
          func();
        },
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        ),
      );
    }

    Widget _form(String lable, void Func()) {
      return Container(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.login), 'Login', _loginContller, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _input(Icon(Icons.lock_open_outlined), 'Password',
                _passwordContller, true),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: _button(lable,Func)
                  )),
        ]),
      );
    }

    void _buttonAction(){
      _login = _loginContller.text;
      _password =  _passwordContller.text;

      _loginContller.clear();
      _passwordContller.clear();
      
    }

    return Scaffold(
        body: Column(
      children: [
        _logo(),
        (
          showLogin
        ? Column(children: [
        _form('login',  _buttonAction),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(child: Text('No registered?',style: TextStyle(fontSize: 20),),
            onTap:(){
              setState((() {
                showLogin = false;
              }));
            },)
          ,)
        ],) 
        :Column(children: [
        _form('register',  _buttonAction),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(child: Text('Alredy registered?',style: TextStyle(fontSize: 20),),
            onTap:(){
              setState((() {
                showLogin = true;
              }));
            },)
          ,)
        ],) 
        )
       
      ],
    ));
  }
}
