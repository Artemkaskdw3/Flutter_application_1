import 'package:flutter/material.dart';
import 'package:flutter_application_1/windows/pages/detailRecipe.dart';

class GridWidget extends StatelessWidget {
  const GridWidget(
      {Key? key, required this.id, required this.title, required this.image})
      : super(key: key);

  final int id;
  final title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailRecipe(id),
                ));
          },
          child: Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: Column(
                children: [
                  Text(title.toString()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
