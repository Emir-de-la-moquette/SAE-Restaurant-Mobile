import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Mapmoi extends StatefulWidget {
  final String nom;
  final double lat;
  final double lon;


  const Mapmoi({super.key, required this.lat, required this.lon, required this.nom});

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
              initialCenter: LatLng(widget.lat, widget.lon),
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
                    point: LatLng(widget.lat, widget.lon), // Position du point
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(Icons.location_pin, color: Colors.red, size: 40),
                        Text(widget.nom, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black)),
                      ],
                    ),
                  ),
                  Marker(
                    point: LatLng(position.latitude, position.longitude),
                    width: 40,
                    height: 40,
                    child: Icon(Icons.person_pin_circle, color: Colors.blue, size: 30),
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