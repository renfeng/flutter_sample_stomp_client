import 'dart:async';
import 'dart:convert';

import 'package:pedantic/pedantic.dart';
import 'package:stomp/stomp.dart';
import 'package:uuid/uuid.dart';
import 'package:websocket/websocket.dart';

import 'stream_service.dart';
import 'stream_stomp_connector.dart';

class StompStreamService extends StreamService<String> {
  StompStreamService({this.url, this.destination, this.login, this.passcode}) {
    assert(url != null);
    assert(destination != null);
  }

  @override
  Future add(String message) async {
    await _connect();
    _stompClient.sendString(destination, message);
  }

  @override
  Future close() => Future.wait([
        if (!_stompClient.isDisconnected) _stompClient.disconnect(),
        super.close(),
      ]);

  final String url;
  final String destination;
  final String login;
  final String passcode;

  StompClient _stompClient;
  WebSocket _ws;

  Future _connect() async {
    if (_ws?.readyState == 1) {
      return;
    }
    _ws = await WebSocket.connect(url);

    StreamController<List<int>> wsIncoming = StreamController();
    StreamController<List<int>> wsOutgoing = StreamController();
    unawaited(wsIncoming.addStream(_ws.stream.map((e) => utf8.encode(e))));
    unawaited(_ws.addStream(wsOutgoing.stream.map((e) => utf8.decode(e))));

    _stompClient = await StompClient.connect(
      StreamStompConnector(incoming: wsIncoming, outgoing: wsOutgoing),
      login: login, passcode: passcode,
//      heartbeat: [1000, 1000],
    );
    _stompClient.subscribeString(
      Uuid().v4(),
      destination,
      (Map<String, String> headers, String message) => onMessage(message),
    );
  }
}
