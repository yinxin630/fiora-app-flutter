import 'package:socket_io_client/socket_io_client.dart' as IO;

//String socketURL = 'http://127.0.0.1:9200';
String socketURL = 'https://fiora.suisuijiang.com';

IO.Socket socket = IO.io(socketURL, <String, dynamic>{
  'transports': ['websocket'],
});

void init() {
  socket.on('connect', (_) => print('connect'));
  socket.on('disconnect', (_) => print('disconnect'));
}
