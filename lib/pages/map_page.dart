import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late StreamSubscription<Position> positionStreamSubscription;
  late LocationPermission permission;

  Future<void> checkPermission() async {
    permission = await Geolocator.checkPermission();
  }

  Future<void> requestPermission() async {
    permission = await Geolocator.requestPermission();
  }

  bool get hasPermission {
    return ![
      LocationPermission.denied,
      LocationPermission.deniedForever,
      LocationPermission.unableToDetermine
    ].contains(permission);
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await checkPermission();
    if (!hasPermission) {
      await requestPermission();
      if (!hasPermission) {
        return;
      }
    }
    positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    )).listen((Position position) {
      mapController.animateCamera(CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps Demo")),
      body: Center(
          child: Container(
              child: GoogleMap(
                  onMapCreated: onMapCreated,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onCameraMove: (CameraPosition cameraPosition) {},
                  onCameraIdle: () async {},
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(51.3, 0),
                    zoom: 18,
                  ),
                  markers: {}))),
    );
  }
}
