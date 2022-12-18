import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipeDETAIL.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailRecipe extends StatefulWidget {
  final int recipeId;
  const DetailRecipe(this.recipeId, {Key? key}) : super(key: key);

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ZaEdy',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<RecipesDetail>(
        future: RecipesApi.getDetailInformation(widget.recipeId),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final details = snapshot.data;
          final originalLenght = details!.extendedIngredients.length;
          final listOriginal = details.extendedIngredients;

          Widget getOriginal(List<ExtendedIngredients> listOriginal) {
            String listOriginall = "";
            for (var i = 0; i < originalLenght; i++) {
              listOriginall +=
                  details.extendedIngredients[i].original + ", " + "\n";
            }
            return AutoSizeText("Ingredients: \n $listOriginall",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.left);
          }

          return Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      details.title,
                      style: TextStyle(fontSize: 25),
                      
                    ),
                  ),
                  SizedBox(
                    child: Padding(padding: EdgeInsets.only(bottom: 15)),
                  ),
                  Container(
                    height: 250,
                    width: 350,
                    child: Image.network(
                      details.image ??
                          "https://spoonacular.com/recipeImages/642054-556x370.jpg",
                      fit: BoxFit.none,
                      
                    ),
                  ),
                  SizedBox(
                    child: Padding(padding: EdgeInsets.only(top: 20)),
                  ),
                  Container(
                  alignment: Alignment.bottomLeft,
                  child: getOriginal(listOriginal)
                  ),
                ],
              ))
            ],
          );
        }),
      )),
    );
  }
}
