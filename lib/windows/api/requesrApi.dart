import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter_application_1/windows/models/AnalyzedRecipeInformation.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';

import 'package:http/http.dart' as http;

import '../models/informationOfRecipeDETAIL.dart';
import '../models/serachInformation.dart';

class RecipesApi {
  static Future<List<Recipes>> getRecipe() async {
    Uri url = Uri.parse('https://api.spoonacular.com/recipes/random?number=10');
    Map<String, String> headers = HashMap();
    headers.addAll({'X-API-KEY': '5715318a4f22412aafba23199118a860'});
    headers.addAll({'content-type': 'application/json'});

    final response = await http.get(
      url,
      headers: headers,
    );
    final responseText = utf8.decode(response.bodyBytes);
    final x = json.decode(responseText);

    return List<Recipes>.from(
        x['recipes'].map((e) => Recipes.fromJson(e)).toList());
  }

  static Future<List<Search>> getSearch(String query) async {
    Uri url = Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${query}');
    Map<String, String> headers = HashMap();
    headers.addAll({'X-API-KEY': '5715318a4f22412aafba23199118a860'});
    headers.addAll({'content-type': 'application/json'});

    final response = await http.get(
      url,
      headers: headers,
    );
    final responseText = utf8.decode(response.bodyBytes);
    final x = json.decode(responseText);
    return List<Search>.from(x['results'].map((e) => Search.fromJson(e)).toList());
  }

  static Future<RecipesDetail> getDetailInformation(int idRecipe) async {
    Uri url = Uri.parse('https://api.spoonacular.com/recipes/${idRecipe}/information');
    Map<String, String> headers = HashMap();
    headers.addAll({'X-API-KEY': '5715318a4f22412aafba23199118a860'});
    headers.addAll({'content-type': 'application/json'});

    final response = await http.get(
      url,
      headers: headers,
    );
    final responseText = utf8.decode(response.bodyBytes);
    final x = json.decode(responseText);
    RecipesDetail recipesDetaill = RecipesDetail.fromJson(x);
    return recipesDetaill;
  }

  static Future<List<StepsOfRecipe>> getSteps(int idRecipe) async {
    Uri url = Uri.parse('https://api.spoonacular.com/recipes/${idRecipe}/analyzedInstructions');
    Map<String, String> headers = HashMap();
    headers.addAll({'X-API-KEY': '5715318a4f22412aafba23199118a860'});
    headers.addAll({'content-type': 'application/json'});

    final response = await http.get(
      url,
      headers: headers,
    );
    final responseText = utf8.decode(response.bodyBytes);
    final x = json.decode(responseText);
    
  
    return List<StepsOfRecipe>.from(x.map((e) => StepsOfRecipe.fromJson(e)).toList());
  }
}
