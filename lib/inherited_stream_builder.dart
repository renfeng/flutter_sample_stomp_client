import 'package:flutter/material.dart';

import 'stream_service.dart';

class InheritedStreamBuilder<Service extends StreamService<StreamEvent>,
    StreamEvent> extends InheritedWidget {
  static T of<T extends InheritedWidget>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<T>();
  }

  final Service service;
  final AsyncWidgetBuilder<StreamEvent> builder;

  InheritedStreamBuilder({
    @required this.service,
    @required this.builder,
    StreamEvent initialData,
  })  : assert(service != null),
        super(
          child: StreamBuilder<StreamEvent>(
            initialData: initialData,
            stream: service.stream,
            builder: builder,
          ),
        );

  @override
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
