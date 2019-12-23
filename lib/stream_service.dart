import 'dart:async';

abstract class StreamService<StreamEvent>
    implements StreamConsumer<StreamEvent>, Sink<StreamEvent> {
  StreamService() {
    _outgoing.stream.listen(add);
  }

  get stream => _incoming.stream;

  @override
  Future close() => Future.wait([
        _incoming.close(),
        _outgoing.close(),
      ]);

  @override
  Future addStream(Stream stream) => _outgoing.addStream(stream);

  @override
  Future add(StreamEvent message);

  void onMessage(StreamEvent message) => _incoming.add(message);

  final StreamController<StreamEvent> _incoming = StreamController.broadcast();
  final StreamController<StreamEvent> _outgoing = StreamController();
}
