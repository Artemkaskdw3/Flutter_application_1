import 'package:flutter/material.dart';

class StepsOfRecipe {
    StepsOfRecipe({
     

     
        required this.steps,
    });
   
 
     List<Steps> steps;

    factory StepsOfRecipe.fromJson(Map<String, dynamic> json) => StepsOfRecipe(
 
      
        steps: List<Steps>.from((json['steps'].map((x) => Steps.fromJson(x)))),

    );

    Map<String, dynamic> toJson() => {
        
      
         "steps": List<dynamic>.from(steps.map((e) => e.toJson())),
    };
}

class Steps{
  Steps({
  
    required this.number,
    required this.step
  });
 
  int number;
  String step;

  factory Steps.fromJson(Map<String,dynamic> json) => Steps(
   
    number: json['number'],
    step: json["step"]
    );
    Map<String,dynamic> toJson() =>{
      
      "number": number,
      "step": step,
    };
}