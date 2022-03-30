import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_compass/flutter_compass.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng userLoc = LatLng(53.472164, -2.238193);
  final MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;
  List<Marker> markers = [];

  void initState() {
    markers.add(Marker(
      point: LatLng(53.472164, -2.238193),
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.black87,
        size: 50.0,
      ),
    ));
    getLocationOnInit();
  }

  void getLocationOnInit() async {
    await _getCurrentLocation();
    Marker userMarker = Marker(
      point: userLoc,
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.black87,
        size: 0,
      ),
    );
    markers[0] = userMarker;
    // Socket io send location
  }

// Example Marker
  //  Marker(
  //     point: LatLng(53.472164, -2.238193),
  //     builder: (ctx) => const Icon(
  //       Icons.location_on,
  //       color: Colors.black87,
  //       size: 50.0,
  //     ),
  //   ),

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

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
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

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      updateMapLocationOnPositionChange: false,
      zoomToCurrentLocationOnLoad: true,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "getCurrentLocation",
          onPressed: () async {
            await _getCurrentLocation();
            userLocationOptions.updateMapLocationOnPositionChange = true;
            // SocketIo send location
          },
          child: const Text('Get User Location')),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: userLoc,
                  zoom: 15,
                  plugins: [
                    UserLocationPlugin(),
                  ],
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  if (markers.length > 1) MarkerLayerOptions(markers: markers),
                  userLocationOptions,
                ],
                mapController: mapController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
