import 'package:flutter/material.dart';
import 'home.dart';
import 'socket.dart';
import 'pages/home/home.dart';
import 'pages/map/map.dart';
import 'pages/chat/chat.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
    ),
  );
}
