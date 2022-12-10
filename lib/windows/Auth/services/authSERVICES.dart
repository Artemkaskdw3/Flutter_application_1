import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/windows/Auth/services/user.dart';

class AuthService{
final FirebaseAuth _FAuth = FirebaseAuth.instance;

    Future<AuthUser?> signInWithEmailAndPassword(String email,String password) async{
      try{
        UserCredential result = await _FAuth.signInWithEmailAndPassword(email: email, password: password);
          User? user = result.user;
           return AuthUser.fromFirebase(user);
      }catch(e){
        return null;
      }
    }

      Future<AuthUser?> registrWithEmailAndPassword(String email,String password) async{
      try{
        UserCredential result = await _FAuth.createUserWithEmailAndPassword(email: email, password: password);
          User? user = result.user;
           return AuthUser.fromFirebase(user);
      }catch(e){
        return null;
      }
    }
    
    Future logOut() async{
      await _FAuth.signOut();
    }
      Stream<AuthUser?> get currentUser {
    return _FAuth
        .authStateChanges()
        .map((User? user) => user != null ? AuthUser.fromFirebase(user) : null);
  }
}
