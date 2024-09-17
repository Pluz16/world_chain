import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class GeoJsonMap extends StatefulWidget {
  const GeoJsonMap({super.key});

  @override
  _GeoJsonMapState createState() => _GeoJsonMapState();
}

class _GeoJsonMapState extends State<GeoJsonMap> {
  final MapController _mapController = MapController();
  List<Polygon> polygons = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadGeoJson();
  }

  Future<void> loadGeoJson() async {
    try {
      final geoJsonData = await rootBundle.loadString('assets/europe.geojson');
      final data = jsonDecode(geoJsonData);

      List<Polygon> loadedPolygons = [];  // Raccogli i poligoni in una lista temporanea

      for (var feature in data['features']) {
        if (feature['geometry']['type'] == 'Polygon' || feature['geometry']['type'] == 'MultiPolygon') {
          List<LatLng> points = [];

          if (feature['geometry']['type'] == 'Polygon') {
            for (var coord in feature['geometry']['coordinates'][0]) {
              points.add(LatLng(coord[1], coord[0]));
            }
          } else if (feature['geometry']['type'] == 'MultiPolygon') {
            for (var polygon in feature['geometry']['coordinates']) {
              for (var coord in polygon[0]) {
                points.add(LatLng(coord[1], coord[0]));
              }
            }
          }

          // Aggiungi il poligono alla lista
          loadedPolygons.add(
            Polygon(
              points: points,
              color: Colors.blue.withOpacity(0.3),
              borderStrokeWidth: 2,
              borderColor: Colors.blue,
            ),
          );
        }
      }

      // Aggiorna lo stato una volta sola
      setState(() {
        polygons = loadedPolygons;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Errore nel caricamento della mappa: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mappa GeoJSON dell\'Europa'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())  // Mostra un indicatore di caricamento
          : errorMessage != null
              ? Center(child: Text(errorMessage!))  // Mostra un messaggio di errore se c'è
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    onMapReady: () {
                      _mapController.move(LatLng(51.5, 10.0), 5.0);  // Imposta centro e zoom
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      tileProvider: CancellableNetworkTileProvider(),  // Usa il provider ottimizzato
                    ),
                    PolygonLayer(polygons: polygons),
                  ],
                ),
    );
  }
}
