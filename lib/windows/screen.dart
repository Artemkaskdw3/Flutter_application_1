import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';

import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Recipes>> recipes;

  @override
  void initState() {
    super.initState();
    recipes = RecipesApi.getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<Recipes>>(
              future: RecipesApi.getRecipe(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final films = snapshot.data;

                return ListView.builder(
                    itemCount: films!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final recipe = films[index];
                      return Padding(
                          padding:
                              EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  recipe.title,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Image.network(
                                recipe.image,
                                fit: BoxFit.fill,
                                width: 350,
                                height: 200,
                              ),
                            ],
                          ));
                    });
              }),
        ),
      ),
    );
  }
}
