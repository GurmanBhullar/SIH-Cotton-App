import 'package:flutter/material.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:flutter_ui_collections/widgets/widgets.dart';

class NewsPage extends StatelessWidget {
  String title, body;
  NewsPage({this.title, this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Forum")),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.share),
          ),
        ],
        backgroundColor: colorCurve,
        elevation: 50.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: latestText(title),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              body,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}

GradientText latestText(String text) {
  return GradientText(text,
      gradient: LinearGradient(colors: [
        Color.fromRGBO(97, 6, 165, 1.0),
        Color.fromRGBO(45, 160, 240, 1.0)
      ]),
      style: TextStyle(
          fontFamily: 'Exo2', fontSize: 20, fontWeight: FontWeight.bold));
}
