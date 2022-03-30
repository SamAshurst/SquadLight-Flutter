import 'package:flutter/material.dart';
import 'socket.dart';
import 'package:socket_io_client/socket_io_client.dart';

class InheritedSocket extends InheritedWidget {
  final Socket socket = io(
      'http://squadlight-node.herokuapp.com/',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  InheritedSocket({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedSocket of(BuildContext context) {
    final InheritedSocket? result =
        context.dependOnInheritedWidgetOfExactType<InheritedSocket>();
    assert(result != null, 'No InheritedSocket found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedSocket old) {
    return true;
  }
}
