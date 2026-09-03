import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> register(String userEmail, String userPassword) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return true;
    } catch (error) {
      print("Error during register: " + error.toString());
      return false;
    }
  }

  Future<bool> login(String userEmail, String userPassword) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return true;
    } catch (error) {
      print("Error during login: " + error.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
