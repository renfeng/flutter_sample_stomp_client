import 'dart:async';

class EventBus<StreamEvent> implements Sink<StreamEvent> {
  Stream get stream => _controller.stream;

  @override
  Future close() => _controller.close();

  @override
  void add(StreamEvent message) {
    onEvent(message);
  }

  void onEvent(StreamEvent message) => _controller.add(message);

  final StreamController<StreamEvent> _controller =
      StreamController.broadcast();
}
