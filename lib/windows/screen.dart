import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/api/requesrApi.dart';
import 'package:flutter_application_1/windows/models/informationOfRecipe.dart';

import 'package:http/http.dart' as http;





void main() => runApp(const MyApp());

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
    recipes = RecipesApi.getTopPopular();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body:  Container(
              width: MediaQuery.of(context).size.width,
            
              child: FutureBuilder<List<Recipes>>(
                future: RecipesApi.getTopPopular(),
                builder: (context, snapshot)
                {
                  if(!snapshot.hasData)
                  {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final films = snapshot.data;
            
                  return ListView.builder(

                    itemCount: films!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index)
                    {
                      final recipe = films[index];
                      return Padding(padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(recipe.id.toString()),
                          Text(recipe.title)

                        ],
                      ),
                      
                                            );
                    }
                  );
                }
              ),
            ),
      ),
    );
  }
}