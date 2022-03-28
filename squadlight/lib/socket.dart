import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late IO.Socket socket;

class SocketIo extends ChangeNotifier {
  connect(BuildContext context) {
    try {
      socket = IO.io(
          'http://squadlight-node.herokuapp.com/',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .setExtraHeaders({'foo': 'bar'}) // optional
              .build());
      socket.connect();
      socket.onConnect((_) => print('connect: ${socket.id}'));
      socket.on('location', (data) {
        print(data.toString()); // Currently only prints to terminal
      });
      socket.on('message', (data) {
        print(data.toString()); // Currently only prints to terminal
      });
    } catch (e) {
      print(e.toString());
    }
  }

  joinRoom() {
    socket.emit('joinRoom', 'MJonesTest');
  }

  message() {
    socket.emit('message', "Hello?");
  }

  disconnect() {
    socket.disconnect();
    socket.onDisconnect((_) => print('disconnected'));
  }

  sendLocation(userLoc) async {
    var Lat = userLoc.latitude.toString();
    var Lng = userLoc.longitude.toString();
    var location = {'Lat': Lat, 'Lng': Lng};
    socket.emit('pingLocation', location);
  }
}

// Used in main.dart widgets:

// @override
// void initState() {
//   super.initState();
//   SocketIo().connect(context);
// }
// SocketIo().joinRoom();
// SocketIo().sendLocation(userLoc);
