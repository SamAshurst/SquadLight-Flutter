import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MapPage(),
    ),
  );
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  void initState() {
    initialize();
    super.initState();
  }

  LatLng userLoc = LatLng(53.472164, -2.238193);

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

// Function to get current user location
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLoc = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  late Position _currentPosition;

// Squad List Of Markers
  List<Marker> squadMarkers = [];

//Radius Markers
  List<CircleMarker> circleMarkers = [];

  initialize() {
// Create Markers
    Marker user1 = Marker(
      point: LatLng(53.472164, -2.238193),
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.black87,
        size: 50.0,
      ),
    );
    Marker user2 = Marker(
      point: LatLng(53.475554, -2.230983),
      builder: (ctx) => const Icon(
        Icons.location_on_outlined,
        color: Colors.red,
        size: 50.0,
      ),
    );
    Marker user3 = Marker(
      point: LatLng(53.473158, -2.239189),
      builder: (ctx) => const Icon(
        Icons.location_on_outlined,
        color: Colors.black87,
        size: 50.0,
      ),
    );
    Marker user4 = Marker(
      point: LatLng(53.470958, -2.238189),
      builder: (ctx) => const Icon(
        Icons.location_on_outlined,
        color: Colors.black87,
        size: 50.0,
      ),
    );

    //CircleMarker
    CircleMarker user1Circle = CircleMarker(
      point: LatLng(53.472164, -2.238193),
      color: Colors.blue.withOpacity(0.2),
      borderColor: Colors.blue.withOpacity(0.5),
      borderStrokeWidth: 3.0,
      radius: 80.0,
    );
    CircleMarker user2Circle = CircleMarker(
      point: LatLng(53.475554, -2.230983),
      color: Colors.red.withOpacity(0.2),
      borderColor: Colors.red.withOpacity(0.5),
      borderStrokeWidth: 3.0,
      radius: 80.0,
    );
    CircleMarker user3Circle = CircleMarker(
      point: LatLng(53.473158, -2.239189),
      color: Colors.blue.withOpacity(0.2),
      borderColor: Colors.blue.withOpacity(0.5),
      borderStrokeWidth: 3.0,
      radius: 80.0,
    );
    CircleMarker user4Circle = CircleMarker(
      point: LatLng(53.470958, -2.238189),
      color: Colors.blue.withOpacity(0.2),
      borderColor: Colors.blue.withOpacity(0.5),
      borderStrokeWidth: 3.0,
      radius: 80.0,
    );

// Add Markers To List
    setState(() {
      squadMarkers.add(user1);
      squadMarkers.add(user2);
      squadMarkers.add(user3);
      squadMarkers.add(user4);
    });

    setState(() {
      circleMarkers.add(user1Circle);
      circleMarkers.add(user2Circle);
      circleMarkers.add(user3Circle);
      circleMarkers.add(user4Circle);
    });
  }

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
    // Squad Page
    Icon(
      Icons.group,
      size: 150,
    ),
    // Chat Page
    Icon(
      Icons.forum,
      size: 150,
    ),
    // Map Page
    Flexible(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(53.472164, -2.238193),
          zoom: 15,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SquadLight"),
        backgroundColor: Colors.grey[850],
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
            icon: Icon(Icons.groups),
            label: "Squad",
          ),
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
