import 'package:flutter/material.dart';

class RecipesDetail {
    RecipesDetail({
        required this.id,
        required this.title,
        required this.image,
        required this.extendedIngredients,
    });

    int id;
    String title;
    String image;
     List<ExtendedIngredients> extendedIngredients;

    factory RecipesDetail.fromJson(Map<String, dynamic> json) => RecipesDetail(
        id: json["id"],
        title: json["title"],
        image: json["image"] ?? "https://spoonacular.com/recipeImages/642054-556x370.jpg",
        extendedIngredients: List<ExtendedIngredients>.from((json['extendedIngredients'].map((x) => ExtendedIngredients.fromJson(x)))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
         "extendedIngredients": List<dynamic>.from(extendedIngredients.map((e) => e.toJson())),
    };
}

class ExtendedIngredients{
  ExtendedIngredients({
    required this.extendedIngredients,
    required this.original
  });
  String extendedIngredients;
  var original;

  factory ExtendedIngredients.fromJson(Map<String,dynamic> json) => ExtendedIngredients(
    extendedIngredients: json['extendedIngredients'] ?? '',
    original: json["original"]
    );
    Map<String,dynamic> toJson() =>{
      "extendedIngredients": extendedIngredients,
      "original": original,
    };
}