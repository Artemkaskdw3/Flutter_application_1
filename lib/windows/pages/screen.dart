import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';
import 'package:flutter_application_1/windows/models/serachInformation.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';

import 'package:http/http.dart' as http;

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late Future<List<Recipes>> recipes;
  String _textFromField = ' ';
  Future<List<Search>>? mFuture;
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
      body: Expanded (
            
        child: SingleChildScrollView (child: Column(
          children: [
            Container(
              
              margin: const EdgeInsets.only(top: 2, left: 14),
              height: 30,
              child: TextField(
                onSubmitted: (value) {
                  _textFromField = value;
                  setState(() {
                    
                    
                      mFuture = RecipesApi.getSearch(value);
                    
                  });
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Search",
                  icon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Search>>(
                  future: mFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return  Container(
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
            );
                    }
                    final recipessearch = snapshot.data;
                    return Container(
                        margin: const EdgeInsets.only(left: 14, top: 4, bottom: 4),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: recipessearch!.length,
                            itemBuilder: (context, index) {
                              final recipeSerrch = recipessearch[index];
                              return Container(
                                child: GestureDetector(
                                  child: Column(
                                    children: [
                                      Text(
                                        recipeSerrch.title,
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      SizedBox(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 15)),
                                      ),
                                      Image.network(
                                        recipeSerrch.image.toString(),
                                        fit: BoxFit.fill,
                                        width: 350,
                                        height: 200,
                                      ),
                                      SizedBox(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 100)),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailRecipe(recipeSerrch.id),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }));
                  }),
            ),

            SizedBox(
              height: 20,
            ),

            // Container(
            //   child: FutureBuilder<List<Recipes>>(
            //       future: RecipesApi.getRecipe(),
            //       builder: (context, snapshot) {
            //         if (!snapshot.hasData) {
            //           return const Center(child: CircularProgressIndicator());
            //         }
            //         final recipess = snapshot.data;
            //         return ListView.builder(
            //             physics: NeverScrollableScrollPhysics(),
            //             itemCount: recipess!.length,
            //             shrinkWrap: true,
            //             itemBuilder: (context, index) {
            //               final recipe = recipess[index];
            //               return Container(
            //                 child: GestureDetector(
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                         recipe.title,
            //                         style: TextStyle(fontSize: 25),
            //                       ),
            //                       SizedBox(
            //                         child: Padding(padding: EdgeInsets.only(bottom: 15) ),
            //                       ),
            //                       Image.network(
            //                         recipe.image.toString(),
            //                         fit: BoxFit.fill,
            //                         width: 350,
            //                         height: 200,
            //                       ),
            //                         SizedBox(
            //                         child: Padding(padding: EdgeInsets.only(top: 100) ),
            //                       ),
            //                     ],
            //                   ),
            //                   onTap: () {
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) =>
            //                             DetailRecipe(recipe.id),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               );
            //             });
            //       }),
            // ),
          ],
        ),
      
    )));
  }
}

