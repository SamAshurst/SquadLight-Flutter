import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'socket.dart';
import 'pages/home/home.dart';
import 'pages/map/map.dart';
import 'pages/chat/chat.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
// Navigation - Current Selected Item
  int _selectedIndex = 0;

// Navigation - On Tap Switch Selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// Navigation - Pages
  List<Widget> _pages = <Widget>[
    // HomePage(),
    ChatPage(),
    MapPage(),
  ];

  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SquadLight"),
        backgroundColor: Colors.grey[850],
        actions: [
          PopupMenuButton(
            offset: Offset(0.0, appBarHeight),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Leave Squad'),
                onTap: () {
                  print("home screen");
                },
              )
            ],
          )
        ],
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[850],
        unselectedItemColor: Colors.grey,
        selectedFontSize: 16,
        selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
