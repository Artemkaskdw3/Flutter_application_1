import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';

import 'package:http/http.dart' as http;


class RecipesApi{

  static Future<List<Recipes>> getTopPopular() async {
    Uri url = Uri.parse('https://api.spoonacular.com/recipes/716429/information?includeNutrition=false');
    Map<String, String> headers = HashMap();
    headers.addAll({'X-API-KEY': '5715318a4f22412aafba23199118a860'});
    headers.addAll({'content-type': 'application/json'});

    final response = await http.get(
      url,
      headers: headers,
    );
    final responseText = utf8.decode(response.bodyBytes);
    final x = json.decode(responseText);
    return List<Recipes>.from(x["recipes"].map((e) => Recipes.fromJson(e)).toList());
  }
}