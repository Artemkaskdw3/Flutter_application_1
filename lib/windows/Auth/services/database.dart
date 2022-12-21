import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';

import '../../models/informationOfRecipeDETAIL.dart';

class DatabaseService{
  static User? user = FirebaseAuth.instance.currentUser;
  final  _recipeDetailsCollection = FirebaseFirestore.instance.collection(user!.uid.toString());


  Future addFilmIsFavorites(RecipesDetail detailRecipe) async{
    Map<String, dynamic> map = HashMap();
    map.addAll({'recipeId': detailRecipe.id});
    map.addAll({'title': detailRecipe.title});
    map.addAll({'image': detailRecipe.image});
    map.addAll({'favorites': true});


    return await _recipeDetailsCollection.doc((detailRecipe.id).toString()).set(map);
  }

 

  Future deleteRecipe(RecipesDetail deleteRecipe) async{
    return await _recipeDetailsCollection.doc((deleteRecipe.id).toString()).delete();
  }
}