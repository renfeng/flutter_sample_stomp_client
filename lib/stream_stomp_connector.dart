import 'dart:async';

import 'package:stomp/impl/plugin.dart';

class StreamStompConnector extends BytesStompConnector {
  final StreamController<List<int>> incoming;
  final StreamController<List<int>> outgoing;

  StreamStompConnector({this.incoming, this.outgoing}) {
    incoming.stream.listen((data) {
      if (data != null && data.isNotEmpty) {
        onBytes(data);
      }
    }, onError: (error, stackTrace) {
      onError(error, stackTrace);
    }, onDone: () {
      onClose();
    });
  }

  @override
  Future close() => null;

  @override
  void writeBytes_(bytes) => outgoing.add(bytes);

  @override
  Future writeStream_(stream) => outgoing.addStream(stream);
}
