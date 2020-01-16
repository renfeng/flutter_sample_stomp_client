import 'package:flutter/widgets.dart';

import 'event_bus.dart';
import 'inherited_stream_builder.dart';
import 'stomp_event_bus.dart';

class EventBuilder extends InheritedStreamBuilder<EventBus<String>, String> {
  static T of<T extends EventBuilder>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<T>();

  EventBuilder({
    @required this.stomp,
    @required builder,
    String initialData,
  }) : super(eventBus: EventBus(), builder: builder, initialData: initialData) {
    stomp.stream.listen((message) => eventBus.add(message));
  }

  final StompEventBus stomp;

  void add(String message) {
    if (isRemote(message)) {
      stomp.add(message);
    } else {
      eventBus.add(message);
    }
  }

  // TODO implement
  bool isRemote(data) => true;
}
