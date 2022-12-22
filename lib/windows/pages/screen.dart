import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/windows/Auth/services/authSERVICES.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';
import 'package:flutter_application_1/windows/models/serachInformation.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';
import 'package:flutter_application_1/windows/pages/favorites.dart';


import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late Future<List<Recipes>> recipes;
  String _textFromField = ' ';
  Future<List<Search>>? mFuture;

  final ScrollController _controller = ScrollController();

  void _scrollToTop() {
    if (_controller.hasClients) {
      _controller.animateTo(0,
          duration: const Duration(milliseconds: 30), curve: Curves.linear);
    }
  }

  @override
  void initState() {
    super.initState();
    recipes = RecipesApi.getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   const Text(
              'ZaEdy',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading:   IconButton(
              onPressed: () {
               
                AuthService().logOut();
               
              
                
              },
              icon: Icon(Icons.logout_outlined),
              alignment: Alignment.centerLeft,
            ),
        actions: [
           
          
          IconButton(
              onPressed: () {
                setState(() {
                  _scrollToTop();
                  Screen();

                  _textFromField = "";
                });
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            child: Padding(padding: EdgeInsets.only(bottom: 15)),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            child: TextField(
              style: TextStyle(fontSize: 25),
              onSubmitted: (value) {
                _textFromField = value;
                setState(() {
                  mFuture = RecipesApi.getSearch(value);
                  _scrollToTop();
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 1),
                hintStyle: const TextStyle(color: Colors.black45, fontSize: 25),
                hintText: "Search",
                icon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white30,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            child: Padding(padding: EdgeInsets.only(bottom: 15)),
          ),
          Expanded(
            child: FutureBuilder<List<Search>>(
                future: mFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || _textFromField == "") {
                    return Container(
                      child: FutureBuilder<List<Recipes>>(
                          future: RecipesApi.getRecipe(),
                          builder: (context, snapshott) {
                            if (!snapshott.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final recipess = snapshott.data;

                            return Scrollbar(
                                child: ListView.builder(
                                    itemCount: recipess!.length,
                                    shrinkWrap: true,
                                    controller: _controller,
                                    itemBuilder: (context, index) {
                                      final recipe = recipess[index];

                                      return Container(
                                        child: GestureDetector(
                                          child: Column(
                                            children: [
                                              
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  recipe.title,
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              ),
                                              SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 15)),
                                              ),
                                              Container(
                                                width: 350,
                                                height: 200,
                                                child: Image.network(
                                                  recipe.image ??
                                                      "https://spoonacular.com/recipeImages/642054-556x370.jpg",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 50)),
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
                                    }));
                          }),
                    );
                  }
                  final recipessearch = snapshot.data;
                  return Container(
                      margin:
                          const EdgeInsets.only(left: 14, top: 4, bottom: 4),
                      child: Scrollbar(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: recipessearch!.length,
                              controller: _controller,
                              itemBuilder: (context, index) {
                                final recipeSerrch = recipessearch[index];
                                return Container(
                                  child: GestureDetector(
                                    child: Column(
                                      children: [
                                    
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            recipeSerrch.title,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 15)),
                                        ),
                                        Image.network(
                                          recipeSerrch.image ??
                                              "https://spoonacular.com/recipeImages/642054-556x370.jpg",
                                          fit: BoxFit.fill,
                                          width: 350,
                                          height: 200,
                                        ),
                                        SizedBox(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 50)),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailRecipe(recipeSerrch.id)),
                                      );
                                    },
                                  ),
                                );
                              })));
                }),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.account_circle_rounded),
        onPressed: () {
        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MainWindow(),
                                              ),
                                            );
      },
      backgroundColor: Colors.black,
      
      )
    );
  }
}
