import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:app/screens/home_screen.dart";
import "package:app/controllers/auth_controller.dart";
import "package:app/controllers/location_controller.dart";
import "package:app/utils/constants.dart";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailBox = TextEditingController();
  TextEditingController passwordBox = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    emailBox.dispose();
    passwordBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(23),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.cardRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_add_alt_1_outlined,
                  size: 60,
                  color: Constants.primaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Constants.primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Start tracking your travels history",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: emailBox,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.borderRadius,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                TextField(
                  controller: passwordBox,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.borderRadius,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Obx(() {
                    if (authController.isLoading.value == true) {
                      return const ElevatedButton(
                        onPressed: null,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Constants.borderRadius,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          String userEmail = emailBox.text.trim();
                          String userPassword = passwordBox.text;

                          bool registerSuccess = await authController.register(
                            userEmail,
                            userPassword,
                          );

                          if (registerSuccess == true) {
                            Get.find<LocationController>().startListening();

                            if (!context.mounted) return;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      );
                    }
                  }),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have account? Login now",
                    style: TextStyle(color: Constants.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
