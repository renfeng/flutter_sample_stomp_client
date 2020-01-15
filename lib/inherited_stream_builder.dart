import 'package:flutter/widgets.dart';

import 'event_bus.dart';

class InheritedStreamBuilder<B extends EventBus<StreamEvent>, StreamEvent>
    extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  InheritedStreamBuilder({
    @required this.eventBus,
    @required this.builder,
    StreamEvent initialData,
  }) : super(
          child: StreamBuilder<StreamEvent>(
            initialData: initialData,
            stream: eventBus.stream,
            builder: builder,
          ),
        );

  final B eventBus;
  final AsyncWidgetBuilder<StreamEvent> builder;
}
