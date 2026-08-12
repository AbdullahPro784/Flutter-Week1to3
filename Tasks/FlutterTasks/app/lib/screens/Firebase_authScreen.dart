import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  String msg = "";

  void showErrorDialog(String txt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$txt fail"),
        content: Text("$txt process failed. Try again!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
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

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      setState(() {
        msg =
            "Account creation successful! ${FirebaseAuth.instance.currentUser?.email}";
        showSuccessDialog("Signup");
      });
    } catch (e) {
      setState(() {
        msg = "Failed to create account. Error";
        showErrorDialog("Signup");
      });
    }
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      setState(() {
        msg = "Login Successful as ${FirebaseAuth.instance.currentUser?.email}";
        showSuccessDialog("Login");
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        msg = "Error $e ! Login fail ";
        showErrorDialog("Login");
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                  ElevatedButton(onPressed: signUp, child: Text("Sign up")),
                  SizedBox(height: 30, width: 20),
                  ElevatedButton(onPressed: signIn, child: Text("Sign in")),
                ],
              ),

              Text(msg),
            ],
          ),
        ),
      ),
    );
  }
}
