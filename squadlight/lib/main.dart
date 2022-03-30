import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/map.dart';
import 'pages/chat.dart';
import 'components/SOSButton.dart';
import 'inheritedSocket.dart';

void main() {
  runApp(
    InheritedSocket(
      child: const MaterialApp(
        home: Home(),
      ),
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
  final List<Widget> _pages = <Widget>[
    ChatScreenGreen(key: Key("TestKey")),
    const MapPage(),
  ];

  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SquadLight"),
        backgroundColor: Colors.grey[850],
        actions: [
          PopupMenuButton(
            offset: Offset(0.0, appBarHeight),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Leave Squad'),
                onTap: () {
                  // Add functionality to leave current squad/room
                },
              )
            ],
          )
        ],
      ),
      floatingActionButton: Container(
          child: const AspectRatio(aspectRatio: 1.0, child: SOSButton())),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[850],
        unselectedItemColor: Colors.grey,
        selectedFontSize: 16,
        selectedIconTheme:
            const IconThemeData(color: Colors.amberAccent, size: 40),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
