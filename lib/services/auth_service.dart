import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:majmu/screens/auth/loginpage.dart';
import 'package:majmu/screens/homepage.dart';

class AuthService {
  // google login variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isSigningIn = false; // Flag to track the sign-in process

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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // after creating the user, create new documents in firestore database
      FirebaseFirestore.instance
          .collection("user-cred")
          .doc(userCredential.user!.email)
          .set({
        "username": email.split("@")[0],
        "profilepicture": "",
      });

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
        return 'An error occurred: please log in with gmail if you previously has registered with it';
      }
    } catch (e) {
      return 'An unexpected error occurred: wrong email or password inserted';
    }
  }

  // Logout method
  void signOut() {
    FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
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

      if (context.mounted) await Future.delayed(const Duration(seconds: 1));

      // Navigate to home page on success
      Navigator.pushNamed(
        context,
        "/home",
      );

      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  // Check if current user signed in with Google
  bool isSignedInWithGoogle() {
    final user = _auth.currentUser;
    if (user != null) {
      // Loop through the provider data and check if it's 'google.com'
      for (final provider in user.providerData) {
        if (provider.providerId == 'google.com') {
          return true;
        }
      }
    }
    return false;
  }

  // forgot password method
  Future<String?> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (context.mounted) Navigator.pop(context);
      Navigator.pop(context);

      // Show success message
      return 'Password reset email sent. Check your inbox.';
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // Handle specific Firebase exceptions
      if (e.code == 'invalid-email') {
        return 'Invalid email address';
      } else if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else {
        return 'An error occurred. Please try again.';
      }
    } catch (e) {
      Navigator.pop(context);
      return 'An unexpected error occurred. Please try again.';
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
