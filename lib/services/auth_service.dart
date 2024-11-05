import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image/image.dart' as img;
import 'package:majmu/screens/auth/registerpage.dart';
import 'package:majmu/screens/bannedpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:path_provider/path_provider.dart';

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
    required File profilePictureFile,
  }) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal of the dialog
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // Close the loading dialog after the user is registered
      if (context.mounted) Navigator.pop(context);

      // Navigate to the homepage right after user registration
      Navigator.pushNamed(context, "/home");

      // Start uploading the profile picture and saving user info in Firestore in the background
      _saveUserProfile(profilePictureFile, uid, email);

      return null;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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

  Future<void> _saveUserProfile(
    File profilePictureFile,
    String uid,
    String email,
  ) async {
    try {
      // Compress and upload the profile picture
      String profilePictureUrl =
          await uploadFileToNestedFolder(profilePictureFile, uid);

      // Save user information in Firestore
      await FirebaseFirestore.instance.collection("user-cred").doc(uid).set({
        "username": email.split("@")[0],
        "email": email,
        "profilePicture": profilePictureUrl,
        "isBanned": false,
        "bannedBy": "",
        "banReason": "",
        "postPublicBookmark": [],
      });

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('user-cred').doc(uid);

      // Add empty sub-collections for bookmarks and delete the initialList right after
      await userDocRef
          .collection("contentsPublicBookmark")
          .doc("initialList")
          .set({});
      await userDocRef
          .collection("contentsPublicBookmark")
          .doc("initialList")
          .delete();

      await userDocRef
          .collection("postPublicBookmark")
          .doc("initialList")
          .set({});

      await userDocRef
          .collection("postPublicBookmark")
          .doc("initialList")
          .delete();

      await userDocRef
          .collection("privateBookmarks")
          .doc("initialList")
          .set({});

      await userDocRef
          .collection("privateBookmarks")
          .doc("initialList")
          .delete();
    } catch (e) {
      print("Error saving user profile: $e");
    }
  }

  // Upload profile picture from registration email or google
  Future<String> uploadFileToNestedFolder(File file, String uid) async {
    // instance of userpfp/ storage folder
    Reference userpfp = FirebaseStorage.instance.ref().child('userpfp');

    // fetch the current user email
    final currentUser = FirebaseAuth.instance.currentUser!.email;

    // create a new sub-folder under userpfp/ folder in firebase storage
    Reference userUIDpfp = userpfp.child(uid);

    // upload the default image to firebase storage
    UploadTask uploadTask =
        userUIDpfp.child('${currentUser}.jpg').putFile(file);

    // fetch the upload task
    TaskSnapshot taskSnapshot = await uploadTask;

    // change the upload task to URL
    return await taskSnapshot.ref.getDownloadURL();
  }

  // Login method
  Future<String?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) Navigator.pop(context);

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushNamed(context, "/home");

      return null;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided';
      } else {
        return 'An error occurred: please log in with Gmail if you previously registered with it';
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

  // Google Sign-In method
  Future<User?> signInWithGoogle(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Navigator.pop(context);
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // to fetch user credentials from firebase auth
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      //
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user-cred')
            .doc(user.uid)
            .get();

        Future<File> assetImageToFile(String assetPath) async {
          ByteData byteData = await rootBundle.load(assetPath);
          Uint8List uint8List = byteData.buffer.asUint8List();
          Directory tempDir = await getTemporaryDirectory();
          File tempFile = File('${tempDir.path}/temp_profile_picture.jpg');
          await tempFile.writeAsBytes(uint8List);
          return tempFile;
        }

        File profilePictureFile =
            await assetImageToFile('assets/baseProfilePicture.png');

        String profilePictureUrl =
            await uploadFileToNestedFolder(profilePictureFile, user.uid);

        if (!userDoc.exists) {
          // Reference to the user's document
          DocumentReference userDocRef =
              FirebaseFirestore.instance.collection('user-cred').doc(user.uid);

          // Create the user document with basic fields
          await userDocRef.set({
            "username": user.email!.split("@")[0],
            "email": user.email!,
            "profilePicture": profilePictureUrl,
            "isBanned": false,
            "bannedBy": "",
            "banReason": "",
            "postPublicBookmark": [],
          });

          // Add empty sub-collections for bookmarks and delete the initialList right after
          await userDocRef
              .collection("contentsPublicBookmark")
              .doc("initialList")
              .set({});
          await userDocRef
              .collection("contentsPublicBookmark")
              .doc("initialList")
              .delete();

          await userDocRef
              .collection("postPublicBookmark")
              .doc("initialList")
              .set({});

          await userDocRef
              .collection("postPublicBookmark")
              .doc("initialList")
              .delete();

          await userDocRef
              .collection("privateBookmarks")
              .doc("initialList")
              .set({});

          await userDocRef
              .collection("privateBookmarks")
              .doc("initialList")
              .delete();
        }

        if (context.mounted) await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context);
        Navigator.pushNamed(context, "/home");

        return user;
      } else {
        Navigator.pop(context);
        return null;
      }
    } catch (e) {
      Navigator.pop(context);
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  // Check if the current user signed in with Google
  bool isSignedInWithGoogle() {
    final user = _auth.currentUser;
    if (user != null) {
      for (final provider in user.providerData) {
        if (provider.providerId == 'google.com') {
          return true;
        }
      }
    }
    return false;
  }

  // Forgot password method
  Future<String?> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (context.mounted) Navigator.pop(context);
      Navigator.pop(context);

      return 'Password reset email sent. Check your inbox.';
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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

Future<bool?> checkIfUserIsBanned(String currentUser) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUser)
        .get();

    // Check if the document exists and contains the 'isBanned' field
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      // Assuming the field you're checking is called 'isBanned' and it's a boolean
      return documentSnapshot.get('isBanned') as bool?;
    } else {
      return null; // Document doesn't exist or no data found
    }
  } catch (e) {
    print("Error fetching user data: $e");
    return null; // Error occurred
  }
}

class StayLogged extends StatelessWidget {
  StayLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            // check the current user uid
            final currentUser = FirebaseAuth.instance.currentUser!.uid;

            // Use FutureBuilder to handle the async call to checkIfUserIsBanned
            return FutureBuilder<bool?>(
              future: checkIfUserIsBanned(currentUser),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading user data"));
                }

                if (snapshot.hasData && snapshot.data == true) {
                  return const BannedPage();
                }

                // User is not banned, proceed to show the app content
                return const HomePage(); // Your main content
              },
            );
          } else {
            return const RegisterPage();
          }
        },
      ),
    );
  }
}
