import 'package:flutter/material.dart';

class Search {
Search({
required this.id,
required this.title,
required this.image,
});

int id;
String title;
var image;

factory Search.fromJson(Map<String, dynamic> json) => Search(
id: json["id"],
title: json["title"],
image: json["image"],
);

Map<String, dynamic> toJson() => {
"id": id,
"title": title,
"image": image ?? '',
};
}
