import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:app/models/location.dart";
import "package:app/controllers/location_controller.dart";
import "package:app/utils/constants.dart";
import "package:app/utils/helpers.dart";
import "dart:convert";
import "dart:typed_data";
import "dart:io";
import "package:flutter/foundation.dart";

class LocationDetail extends StatelessWidget {
  final Location location;

  const LocationDetail({super.key, required this.location});

  Widget _buildSafeImage(String photoData) {
    try {
      if (photoData.startsWith("http") || photoData.startsWith("blob:")) {
        return Image.network(
          photoData,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        );
      }

      if (photoData.startsWith("/") || photoData.startsWith("C:")) {
        if (kIsWeb) return _errorBox("Local file blocked on Web");
        return Image.file(
          File(photoData),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        );
      }

      if (photoData.length > 1000) {
        String cleanBase64 = photoData;

        if (cleanBase64.contains(",")) {
          cleanBase64 = cleanBase64.split(",").last;
        }

        cleanBase64 = cleanBase64.replaceAll(RegExp(r"\s+"), "");

        Uint8List bytes = base64Decode(cleanBase64);

        return Image.memory(
          bytes,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _errorBox("Base64 Render Error");
          },
        );
      }

      String preview = photoData.length > 15
          ? "${photoData.substring(0, 15)}..."
          : photoData;

      return _errorBox("Unknown:\n$preview");
    } catch (e) {
      return _errorBox("Failed Decode");
    }
  }

  Widget _errorBox(String msg) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[800],
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date: " + Helpers.formatDate(location.date),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Location: ${location.placeName}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Experience / Notes:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                location.notes.isEmpty ? "No notes added yet." : location.notes,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Photos:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            location.photoUrls.isEmpty
                ? const Text(
                    "No photos attached.",
                    style: TextStyle(color: Colors.grey),
                  )
                : Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (String photoText in location.photoUrls)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildSafeImage(photoText),
                        ),
                    ],
                  ),
            const SizedBox(height: 25),
            const Text(
              "Location on Map:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      location.latitude,
                      location.longitude,
                    ),
                    initialZoom: 12,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: "com.user.mapnsnap",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(location.latitude, location.longitude),
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Location"),
          content: Text('Are you sure you want to delete "${location.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Get.find<LocationController>().deleteLocation(
                  location.id,
                );
                if (context.mounted) Navigator.pop(context);
                Get.snackbar("Deleted", "Location removed successfully");
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
