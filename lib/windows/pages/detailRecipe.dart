import 'package:flutter/material.dart';

class DetailRecipe extends StatefulWidget {
  final int recipeId;
  const DetailRecipe(this.recipeId, {Key? key}) : super(key: key);

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Text("sd")),);
  
  }
  }