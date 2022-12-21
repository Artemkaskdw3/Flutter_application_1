import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipeDETAIL.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Auth/services/database.dart';
import '../models/AnalyzedRecipeInformation.dart';

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
                      child: getOriginal(listOriginal)),
                  Container(
                      child: FutureBuilder<List<StepsOfRecipe>>(
                    future: RecipesApi.getSteps(widget.recipeId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final stepsSnap = snapshot.data;
                      final stepsLenght = stepsSnap!.length;
                      final listSteps = stepsSnap;

                      Widget getInstructions(List<StepsOfRecipe> listSteps) {
                        String listStepss = "";
                        for (var i = 0; i < stepsLenght; i++) {
                          for (var j = 0; j < stepsSnap[i].steps.length; j++) {
                            listStepss +=
                                stepsSnap[i].steps[j].step + ", " + "\n";
                          }
                        }
                        return AutoSizeText("Instructions: \n $listStepss",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left);
                      }

                      return Column(
                        children: [
                          Container(child: getInstructions(listSteps)),
                          Container(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                DatabaseService().addFilmIsFavorites(details);
                                Fluttertoast.showToast(
                                    msg: "Добавлен в избранное.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Icon(Icons.turned_in),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  ))
                ],
              ))
            ],
          );
        }),
      )),
    );
  }
}
