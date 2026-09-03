import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:app/controllers/location_controller.dart";
import "package:app/utils/constants.dart";
import "package:app/screens/loc_detail.dart";

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController locationController =
        Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Travel Spots"),
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        List<Marker> tripMarkers = [];

        for (var locationItem in locationController.locationsList) {
          tripMarkers.add(
            Marker(
              point: LatLng(locationItem.latitude, locationItem.longitude),
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => LocationDetail(location: locationItem));
                },
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 45,
                ),
              ),
            ),
          );
        }

        return FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(30.3753, 69.3451),
            initialZoom: 5,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(markers: tripMarkers),
          ],
        );
      }),
    );
  }
}
