import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

const String MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoidG9iZTQwNCIsImEiOiJjbHUwc3FkdzgwYm02MmtvYWJobzlteHBiIn0.9IzHovLls90OXjhKZo_nXw';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;

  Future<void> determinePosition() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final LocationPermission permission =
          await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future<void>.error('Location permission denied');
      }
    }
    final Position position = await Geolocator.getCurrentPosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51.509364, -0.128928),
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: {
              'accessToken': MAPBOX_ACCESS_TOKEN,
            },
            userAgentPackageName: 'com.example.app',
          ),
          RichAttributionWidget(
            attributions: [
              // TextSourceAttribution(
              //   'OpenStreetMap contributors',
              //   onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              // ),
            ],
          ),
        ],
      ),
    ));
  }
}
