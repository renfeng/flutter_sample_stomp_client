import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'inherited_stream_builder.dart';
import 'stomp_stream_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stomp = StompStreamService(
    url: "ws://localhost:15674/ws",
    destination: "/topic/test",
    login: "flutter",
    passcode: "flutter",
  );

  @override
  void dispose() {
    stomp.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedStreamBuilder<StompStreamService, String>(
      service: stomp,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        log("TODO build according to snapshot, ${snapshot.data}");
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Text("${snapshot.data ?? ""}"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              InheritedStreamBuilder.of<
                  InheritedStreamBuilder<StompStreamService, String>>(
                context,
              ).service
                ..add(WordPair.random().asCamelCase);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
