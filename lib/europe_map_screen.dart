import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class GeoJsonMap extends StatefulWidget {
  const GeoJsonMap({Key? key}) : super(key: key);

  @override
  _GeoJsonMapState createState() => _GeoJsonMapState();
}

class _GeoJsonMapState extends State<GeoJsonMap> {
  final MapController _mapController = MapController();
  List<Marker> markers = [];
  List<Polyline> polylines = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadGeoJson();
  }

  Future<void> loadGeoJson() async {
    try {
      final geoJsonData = await rootBundle.loadString('assets/cities.geojson');
      final data = jsonDecode(geoJsonData);

      List<Marker> loadedMarkers = [];
      List<Polyline> loadedPolylines = [];

      for (var feature in data['features']) {
        if (feature['geometry']['type'] == 'Point') {
          var coordinates = feature['geometry']['coordinates'];
          LatLng point = LatLng(coordinates[1], coordinates[0]);

          loadedMarkers.add(
            Marker(
              point: point,
              width: 30.0, // Dimensione icona
              height: 30.0,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 30,
              ),
            ),
          );
        } else if (feature['geometry']['type'] == 'LineString') {
          List<LatLng> points = [];
          for (var coord in feature['geometry']['coordinates']) {
            points.add(LatLng(coord[1], coord[0]));
          }

          loadedPolylines.add(
            Polyline(
              points: points,
              color: Colors.blue,
              strokeWidth: 3.0,
            ),
          );
        }
      }

      setState(() {
        markers = loadedMarkers;
        polylines = loadedPolylines;
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
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(51.5, 10.0), // Centro Europa
                    initialZoom: 5.0, // Zoom iniziale
                    onTap: (tapPosition, latlng) {
                      print('Hai cliccato su: $latlng');
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      tileProvider: CancellableNetworkTileProvider(),
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                    PolylineLayer(
                      polylines: polylines,
                    ),
                  ],
                ),
    );
  }
}
