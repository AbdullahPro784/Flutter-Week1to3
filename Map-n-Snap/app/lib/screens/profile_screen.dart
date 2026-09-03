import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:app/controllers/auth_controller.dart";
import "package:app/controllers/location_controller.dart";
import "package:app/screens/auth/login.dart";
import "package:app/utils/constants.dart";

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final LocationController locationController =
        Get.find<LocationController>();

    final User? currentUser = FirebaseAuth.instance.currentUser;
    String userEmail = currentUser?.email ?? "No email found";

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Constants.primaryColor.withValues(alpha: 0.2),
              child: Icon(
                Icons.person,
                size: 60,
                color: Constants.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Log in as:",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Icon(Icons.map, size: 30, color: Colors.deepPurple),
                      SizedBox(height: 8),
                      Text(
                        "Total Places Saved",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Obx(() {
                    return Text(
                      locationController.locationsList.length.toString(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await authController.logout();
                  Get.offAll(() => const Login());
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
