import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:majmu/screens/auth/loginpage.dart';
import 'package:majmu/screens/homepage.dart';

class AuthService {
  // google login variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Register method
  Future<String?> register({
    required String email,
    required String password,
    required String repassword,
    required BuildContext context,
  }) async {
    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      // Try to create a new user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) Navigator.pop(context);

      // Navigate to home page on success
      Navigator.pushNamed(context, "/home");

      return null; // No error
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // Handle specific Firebase exceptions
      if (e.code == 'weak-password') {
        return 'The password is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The email has already been taken';
      } else {
        return 'An error occurred: email has been used, or weak password';
      }
    } catch (e) {
      return 'An unexpected error occurred: email has been used, or weak password';
    }
  }

  // Login method
  Future<String?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      // Try to sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) Navigator.pop(context);

      await Future.delayed(const Duration(seconds: 1));

      // Navigate to home page on success
      Navigator.pushNamed(
        context,
        "/home",
      );

      return null; // No error
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // Handle specific Firebase exceptions
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided';
      } else {
        return 'An error occurred: wrong email or password inserted';
      }
    } catch (e) {
      return 'An unexpected error occurred: wrong email or password inserted';
    }
  }

  // Logout method
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // method to sign in with google
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }
}

class StayLogged extends StatelessWidget {
  const StayLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshots) {
            // if user is logged in
            if (snapshots.hasData) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
