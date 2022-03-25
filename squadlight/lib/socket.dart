import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:socket_io_client/socket_io_client.dart';

late Socket socket;

class SocketIo {

  void connect() {
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

  joinRoom() {
    socket.emit('joinRoom', 'MJonesTest');
  }

   message () {
    socket.emit('message', "Hello?");
  }

  disconnect() {
    socket.disconnect();
    socket.onDisconnect((_) => print('disconnected'));
  }

  sendLocation(userLoc) async {
    print(userLoc.latitude);
    var Lat = userLoc.latitude.toString();
    var Lng = userLoc.longitude.toString();
    var location = {'Lat': Lat, 'Lng': Lng};
    socket.emit('pingLocation', location);
  }
}
