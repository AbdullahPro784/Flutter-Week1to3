import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

import "package:app/controllers/location_controller.dart";
import "package:app/utils/constants.dart";
import "package:app/utils/helpers.dart";

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final TextEditingController titleBox = TextEditingController();
  final TextEditingController experienceBox = TextEditingController();

  final LocationController locationController = Get.find<LocationController>();

  @override
  void dispose() {
    titleBox.dispose();
    experienceBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Travel Entry"),
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: titleBox,
              decoration: InputDecoration(
                hintText: "Where did you go?",
                prefixIcon: const Icon(Icons.place_outlined),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Constants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              "How was your experience?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: experienceBox,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Tell us about your trip...",
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Icon(Icons.edit_note),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Constants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Date you visited?", style: TextStyle(fontSize: 16)),

            Obx(() {
              return ElevatedButton(
                onPressed: () async {
                  final DateTime? chosenDate = await showDatePicker(
                    context: context,
                    initialDate: locationController.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (chosenDate != null) {
                    locationController.setDate(chosenDate);
                  }
                },
                child: Text(
                  Helpers.formatDate(locationController.selectedDate.value),
                ),
              );
            }),

            const SizedBox(height: 20),

            const Text(
              "Tap map to pinpoint location:",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Container(
              height: 200,
              color: Colors.grey,
              child: Obx(() {
                return FlutterMap(
                  options: MapOptions(
                    initialCenter: const LatLng(31.5204, 74.3587),
                    initialZoom: 5,
                    onTap: (tapPosition, point) {
                      locationController.setPickedLocation(
                        point.latitude,
                        point.longitude,
                      );
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
                      userAgentPackageName: "com.example.app",
                    ),

                    if (locationController.selectedLatitude.value != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              locationController.selectedLatitude.value!,
                              locationController.selectedLongitude.value!,
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 20),

            const Text("Photos:", style: TextStyle(fontSize: 16)),

            ElevatedButton(
              onPressed: () {
                locationController.pickImages();
              },
              child: const Text("Pick Photos"),
            ),

            Obx(() {
              return Wrap(
                spacing: 10,
                children: [
                  for (
                    int i = 0;
                    i < locationController.selectedImages.length;
                    i++
                  )
                    Column(
                      children: [
                        kIsWeb
                            ? Image.network(
                                locationController.selectedImages[i].path,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(locationController.selectedImages[i].path),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),

                        TextButton(
                          onPressed: () {
                            locationController.removeImage(i);
                          },
                          child: const Text(
                            "Remove",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),

            const SizedBox(height: 30),

            Obx(() {
              if (locationController.isSavingForm.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                  ),
                  onPressed: () async {
                    final bool isSuccess = await locationController
                        .saveLocation(titleBox.text, experienceBox.text);

                    if (isSuccess && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save Location",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
