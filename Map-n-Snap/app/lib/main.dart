import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:firebase_core/firebase_core.dart";
import "package:app/controllers/auth_controller.dart";
import "package:app/controllers/location_controller.dart";
import "package:app/screens/auth/login.dart";
import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthController());
  Get.put(LocationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "MapnSnap",
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
