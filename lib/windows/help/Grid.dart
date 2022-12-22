import 'package:auto_size_text/auto_size_text.dart';
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
                  Container(
                    alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                    title.toString(),
                    maxLines: 1,
                    style: TextStyle(fontSize: 20),
                  )),
                  SizedBox(
                    child: Padding(padding: EdgeInsets.only(bottom: 15)),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(padding: EdgeInsets.only(top: 45)),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
