// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:majmu/screens/auth/googlebutton.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/components/edit%20profile%20components/text_box.dart';
import 'package:majmu/components/edit%20profile%20components/userpfp.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/services/auth_service.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img; // Add this import

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  List<File> _images = []; // Store selected images here
  final ImagePicker _picker = ImagePicker();

  // collect all user
  final usersCollection = FirebaseFirestore.instance.collection("user-cred");

  // Pick image from gallery
  Future<void> addImage() async {
    // pick an image frm gallery
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    // Fetch the old user data from Firestore
    DocumentSnapshot oldValueDoc = await FirebaseFirestore.instance
        .collection('user-cred')
        .doc(currentUser.uid)
        .get();

// Extract the old username from the document snapshot
    String oldUserPfp = oldValueDoc['profilePicture'] ??
        ""; // Default to an empty string if not found

    // if an image is picked
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Compress the image before uploading
      img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());

      if (originalImage != null) {
        // Resize and compress the image (reduce quality to 85%)
        img.Image compressedImage =
            img.copyResize(originalImage, width: 800); // Adjust width as needed
        File compressedFile =
            File(pickedFile.path.replaceFirst('.jpg', '_compressed.jpg'))
              ..writeAsBytesSync(img.encodeJpg(compressedImage, quality: 60));

        // Show loading sign
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                Text("Uploading..."),
              ],
            ),
          ),
        );

        try {
          // Get the user's email and encode it to avoid issues with special characters
          String userUID = currentUser.uid!;

          // Fetch existing profile picture URL from Firestore
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection("user-cred")
              .doc(currentUser.uid!)
              .get();

          // Fetch existing profile picture URL from Firestore
          var userDocData = userDoc.data() as Map<String, dynamic>?;

          String oldImageUrl = userDocData?["profilePicture"] ?? "";

          // Check if the old image URL contains "userpfp/"
          if (oldImageUrl.isNotEmpty && oldImageUrl.contains("userpfp/")) {
            String oldImagePath =
                oldImageUrl.substring(oldImageUrl.indexOf("userpfp/"));
            Reference oldImageRef =
                FirebaseStorage.instance.ref().child(oldImagePath);
            await oldImageRef.delete();
          }

          // Create a unique filename for the new image
          String newFileName =
              DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child("userpfp/$userUID/$newFileName");

          // Upload the new compressed image
          await storageRef.putFile(compressedFile);

          // Get the download URL for the new image
          String newDownloadUrl = await storageRef.getDownloadURL();

          // Update Firestore with the new profile picture URL
          await FirebaseFirestore.instance
              .collection("user-cred")
              .doc(currentUser.uid)
              .update({
            "profilePicture": newDownloadUrl,
          });

          // Update the profilePicture in the user-posts collection
          if (oldUserPfp.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection("user-posts")
                .where("pfp",
                    isEqualTo: oldUserPfp) // Use the old username here
                .get()
                .then((snapshot) {
              for (var doc in snapshot.docs) {
                doc.reference.update({"pfp": newDownloadUrl});
              }
            });
          }

          // Hide loading indicator and show success message
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Profile picture updated successfully!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              duration:
                  Duration(seconds: 3), // Show success message for 3 seconds
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          print("Error uploading image: $e");
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update profile picture.'),
              duration:
                  Duration(seconds: 3), // Show error message for 3 seconds
            ),
          );
        }
      }
    } else {
      print("No image selected.");
    }
  }

  Future<void> editField(String field) async {
    String newValue = "";

    // Fetch the old user data from Firestore
    DocumentSnapshot oldValueDoc = await FirebaseFirestore.instance
        .collection('user-cred')
        .doc(currentUser.uid)
        .get();

// Extract the old username from the document snapshot
    String oldUsername = oldValueDoc['username'] ??
        ""; // Default to an empty string if not found

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit" + field,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
              hintText: "Enter new" + field,
              hintStyle: TextStyle(
                color: Colors.grey,
              )),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "cancel",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // save button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newValue);
            },
            child: Text(
              "save",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      // Check if the username is already taken
      final existingUsers =
          await usersCollection.where("username", isEqualTo: newValue).get();

      if (existingUsers.docs.isNotEmpty && newValue != currentUser.uid) {
        // Show error snackbar if the username is already in use
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Username has been used!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Proceed with updating Firestore if the username is unique
        await usersCollection.doc(currentUser.uid).update(({field: newValue}));

        // Update the username in the user-posts collection
        if (oldUsername.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection("user-posts")
              .where("username",
                  isEqualTo: oldUsername) // Use the old username here
              .get()
              .then((snapshot) {
            for (var doc in snapshot.docs) {
              doc.reference.update({"username": newValue});
            }
          });
        }

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "$field updated successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // check if the user is logged with a valid Gmail account
    final AuthService _authService = AuthService();

    bool isLogged = _authService.isSignedInWithGoogle();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 241, 222),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 241, 222),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),

      // fetch the data from firebase firestore "user-cred" collection
      body: isLogged
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("user-cred")
                  .doc(currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return ListView(
                    children: [
                      SizedBox(height: screenHeight * 0.04),

                      // profile text
                      Center(
                        child: Text(
                          "P R O F I L E",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: screenWidth * 0.08,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // profile picture
                      UserPfp(
                        // component
                        image: userData["profilePicture"] ??
                            AssetImage(
                                "baseProfilePicture.png"), // Handle empty profile picture case
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.2,

                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(16),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Close the dialog
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pop(); // Close the AlertDialog
                                          },
                                          child: Text(
                                            "Done",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),

                                    // View profile picture
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pop(); // Close the AlertDialog
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: InstaImageViewer(
                                              child: Image.network(
                                                userData["profilePicture"],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: screenHeight *
                                            0.03, // Adjust this as per your layout
                                        child: Text(
                                          'View Profile Picture',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),

                                    // Change profile picture
                                    GestureDetector(
                                      onTap: () {
                                        addImage();
                                        Navigator.of(context)
                                            .pop(); // Close the AlertDialog
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: screenHeight *
                                            0.03, // Adjust this as per your layout
                                        child: Text(
                                          'Change Profile Picture',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // username
                      MyTextBox(
                        text: userData["username"],
                        sectionName: "Username",
                        onTap: () => editField('username'),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // email
                      MyTextBox(
                        text: userData["email"],
                        sectionName: "Email",
                        onTap: () {},
                      ),

                      // google sign in button
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text("An error occurred: ${snapshot.error}"),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Text(
                      "Verify your account to edit your profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GoogleButton(),
                ],
              ),
            ),
    );
  }
}
