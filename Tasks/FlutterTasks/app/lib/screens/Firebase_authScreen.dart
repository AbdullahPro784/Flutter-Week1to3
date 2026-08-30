import 'package:app/main.dart';
import 'package:app/screens/MyTasks.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "Signup_Screen.dart";

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  void showErrorDialog(String txt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.red.shade50,
              child: Icon(Icons.error_outline, color: Colors.red, size: 45),
            ),
            SizedBox(height: 15),

            Text(
              "Login Failed",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Text(
              txt,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Try Again"),
            ),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog(String txt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$txt success"),
        content: Text("$txt process succeded"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      showErrorDialog(
        e.message ??
            "Error $e ! Login failed. Please check ur email and password. ",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Auth Screen"),
        titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20)),

              Text(
                "Welcome sign up or sign in",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text("Sign up"),
                  ),
                  SizedBox(height: 30, width: 20),
                  ElevatedButton(onPressed: signIn, child: Text("Sign in")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
