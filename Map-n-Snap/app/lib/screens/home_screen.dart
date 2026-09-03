import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:app/controllers/auth_controller.dart";
import "package:app/controllers/location_controller.dart";
import "package:app/screens/auth/login.dart";
import "package:app/screens/add_location_screen.dart";
import "package:app/utils/constants.dart";
import "package:app/utils/helpers.dart";
import "package:app/screens/loc_detail.dart";
import "package:app/screens/profile_screen.dart";
import "package:app/screens/map_screen.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthController authController = Get.find<AuthController>();
  final LocationController locationController = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    locationController.listenToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "MapnSnap",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Get.to(() => const Profile());
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              Get.offAll(() => const Login());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Where to next?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "View travel map below",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                Get.to(() => const MapScreen());
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(Constants.cardRadius),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.map_outlined, size: 46, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      "View visit locations",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent trips",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  int totalSpots = locationController.locationsList.length;
                  return Text(
                    "$totalSpots places visited",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  );
                }),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (locationController.isLoadingDatabase.value == true) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (locationController.locationsList.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Text(
                          "No locations yet",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: locationController.locationsList.length,
                  itemBuilder: (context, index) {
                    var locationItem = locationController.locationsList[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Constants.borderRadius,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Text(
                          locationItem.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(Helpers.formatDate(locationItem.date)),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            confirmDelete(
                              context,
                              locationItem.id,
                              locationItem.title,
                            );
                          },
                        ),
                        onTap: () {
                          Get.to(() => LocationDetail(location: locationItem));
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => const AddLocation());
        },
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }

  void confirmDelete(
    BuildContext context,
    String locationId,
    String locationTitle,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Location"),
          content: Text('Are you sure you want to delete "$locationTitle"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await locationController.deleteLocation(locationId);
                Get.snackbar("Deleted", "Location removed");
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
