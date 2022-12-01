import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';

import 'package:http/http.dart' as http;

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late Future<List<Recipes>> recipes;

  @override
  void initState() {
    super.initState();

    recipes = RecipesApi.getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZaEdy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2, left: 14),
              child: const Text('ТУТ ДОЛЖЕН БЫТЬ ПОИСК',
              style: TextStyle(fontSize: 24),
              ),
            ),
             SizedBox(
                                    height: 20,
                                  ),
            Container(
              child: FutureBuilder<List<Recipes>>(
                  future: RecipesApi.getRecipe(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final recipess = snapshot.data;
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipess!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final recipe = recipess[index];
                          return Container(
                            child: GestureDetector(
                              child: Column(
                                children: [
                                  Text(
                                    recipe.title,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(
                                    child: Padding(padding: EdgeInsets.only(bottom: 15) ),
                                  ),
                                  Image.network(
                                    recipe.image.toString(),
                                    fit: BoxFit.fill,
                                    width: 350,
                                    height: 200,
                                  ),
                                    SizedBox(
                                    child: Padding(padding: EdgeInsets.only(top: 100) ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailRecipe(recipe.id),
                                  ),
                                );
                              },
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
