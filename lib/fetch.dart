import 'dart:async';

import './socket.dart' as Socket;

/// 请求 socket.io 接口
/// 
/// 返回数组 [err, data], 类似 node callback 模式
Future<dynamic> fetch(String event, dynamic data) {
  Completer c = new Completer();
  Socket.socket.emitWithAck(event, data, ack: (dynamic result) {
    if (result is String) {
      c.complete([result, null]);
    } else {
      c.complete([null, result]);
    }
  });
  return c.future;
}
