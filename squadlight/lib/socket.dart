import 'package:socket_io_client/socket_io_client.dart';

late Socket socket;
class SocketIo {


   Future<dynamic>connect() async {
    try {
      socket = io(
          'http://squadlight-node.herokuapp.com/',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build());
      socket.connect();
      socket.onConnect((_) => print('connect: ${socket.id}'));
    } catch (e) {
      print(e.toString());
    }
  }

    void joinRoom(){
    socket.emit('joinRoom', 'MJonesTest');
  }
  void message(){
     socket.emit('message', "Hello?");
  }
}

