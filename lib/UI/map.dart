import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Mapmoi extends StatefulWidget {
  const Mapmoi({super.key});

  @override
  State<Mapmoi> createState() => _MapState();
}

class _MapState extends State<Mapmoi> {

  Future<Position> _getPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: _getPosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Affichage d’un loader en attendant la position
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}')); // Gestion des erreurs
        } else if (snapshot.hasData) {
          final position = snapshot.data!;
          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(position.latitude, position.longitude),
              initialZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(48.8566, 2.3522), // Position du point
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(Icons.location_pin, color: Colors.red, size: 40),
                        Text("Paris", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: Text("Impossible de récupérer la position"));
        }
      },
    );
  }
}