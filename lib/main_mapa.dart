import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:puc_flutter_virtual/services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Location _location = Location();

  @override
  void initState() {
    _location.requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nosso primeiro app',
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Mapa'),
            ),
            body: FutureBuilder(
              future: _getCurrentLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var myLocation = LatLng(snapshot.data?.latitude ?? 0,
                      snapshot.data?.longitude ?? 0);
                  return FlutterMap(
                      options: MapOptions(
                          initialCenter: myLocation, initialZoom: 18),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                              point: myLocation,
                              child: Image.asset("images/image.png"))
                        ])
                      ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }

  Future<LocationData?> _getCurrentLocation() async {
    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      var request = await _location.requestService();
      if (!request) {
        print('GPS não habilitado');
      }

      return null;
    } else {
      var location = await _location.getLocation();
      return location;
    }
  }
}
