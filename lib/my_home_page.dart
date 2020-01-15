import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'event_builder.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title, this.text}) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text("${text ?? ""}"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            EventBuilder.of(context).add(WordPair.random().asCamelCase);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
}
