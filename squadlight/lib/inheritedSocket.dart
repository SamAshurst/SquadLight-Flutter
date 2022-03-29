import 'package:flutter/material.dart';
import 'socket.dart';

class InheritedSocket extends InheritedWidget {
  final SocketIo socket = SocketIo();

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
