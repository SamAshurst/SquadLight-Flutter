import 'package:flutter/material.dart';
import 'package:squadlight/pages/map/map.dart';
import 'converttow3w.dart';

final routes = {
  '/converttow3w': (BuildContext context) => const ConvertTo3WAPage(),
};

class W3WApp extends StatelessWidget {
  const W3WApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'w3w',
      home: const MapPage(),
      routes: routes,
    );
  }
}

void main() => runApp(const W3WApp());