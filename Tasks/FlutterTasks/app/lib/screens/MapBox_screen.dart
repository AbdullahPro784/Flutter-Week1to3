import "package:flutter/material.dart";
import "package:mapbox_maps_flutter/mapbox_maps_flutter.dart";
import "package:geolocator/geolocator.dart" as geo;

class MapboxScreen extends StatefulWidget {
  const MapboxScreen({super.key});

  @override
  State<MapboxScreen> createState() => _MapboxScreenState();
}

class _MapboxScreenState extends State<MapboxScreen> {
  bool showMap = false;
  bool loading = false;
  geo.Position? currentPosition;
  String? errormsg;
  MapboxMap? mapboxMap;

  Future<void> requestPermissionAndShowMap() async {
    setState(() => loading = true);
    try {
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        setState(() {
          errormsg = "Location service is disabled. Please enable it";
          loading = false;
        });
        return;
      }

      geo.LocationPermission permission =
          await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          setState(() {
            errormsg = "Location permission denied";
            loading = false;
          });
          return;
        }
      }
      if (permission == geo.LocationPermission.deniedForever) {
        setState(() {
          errormsg = "Permission forever denied. Enable in settings.";
          loading = false;
        });
        return;
      }

      geo.Position position = await geo.Geolocator.getCurrentPosition(
        locationSettings: geo.LocationSettings(
          accuracy: geo.LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      setState(() {
        currentPosition = position;
        showMap = true;
        errormsg = null;
        loading = false;
      });
    } catch (e) {
      setState(() {
        errormsg = "Error: $e";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapbox Location")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) CircularProgressIndicator(),
            if (errormsg != null)
              Text(errormsg!, style: TextStyle(color: Colors.red)),

            if (showMap && currentPosition != null)
              Container(
                width: 300,
                height: 400,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: MapWidget(
                  cameraOptions: CameraOptions(
                    center: Point(
                      coordinates: Position(
                        currentPosition!.longitude,
                        currentPosition!.latitude,
                      ),
                    ),
                    zoom: 14,
                  ),
                  onMapCreated: (map) {
                    mapboxMap = map;
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: showMap
          ? FloatingActionButton.extended(
              onPressed: () => setState(() => showMap = false),
              icon: Icon(Icons.close),
              label: Text("Hide Map"),
            )
          : FloatingActionButton.extended(
              onPressed: requestPermissionAndShowMap,
              icon: Icon(Icons.map),
              label: Text("Show Map"),
            ),
    );
  }
}
