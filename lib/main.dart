import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:usage/usage.dart';

import 'analytics/analytics.dart';
import 'event_builder.dart';
import 'my_home_page.dart';
import 'stomp_event_bus.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Flutter Demo",
        home: EventBuilder(
          stomp: stomp,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              _ga.sendEvent("screen", snapshot.data);
              _ga.sendScreenView(snapshot.data);
            }
            log("TODO build according to snapshot, ${snapshot.data}");
            return MyHomePage(
              title: "Flutter Demo Home Page",
              text: snapshot.data,
            );
          },
        ),
      );

  @override
  void dispose() {
    stomp.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    analytics(
      trackingId: "UA-549131-12",
      applicationName: "Flutter Demo",
      applicationVersion: "1.0",
    ).then((ga) => _ga = ga);
  }

  final stomp = StompEventBus(
    url: "ws://localhost:15674/ws",
    destination: "/topic/test",
    login: "flutter",
    passcode: "flutter",
  );

  Analytics _ga;
}
