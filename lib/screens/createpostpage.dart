// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/services/auth_service.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _post = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  List<File> _images = []; // Store selected images here
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false; // Track loading state
  String? profilePictureUrl;

  @override
  void initState() {
    super.initState();
    fetchProfilePicture(); // Call this function to fetch the profile picture
  }

  // Function to fetch user profile picture from Firestore
  Future<void> fetchProfilePicture() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists) {
      var userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        profilePictureUrl = userData[
            "profilePicture"]; // Assign the fetched profile picture URL
      });
    }
  }

  // check if the user is logged with a valid Gmail account
  final AuthService _authService = AuthService();

  // Function to compress image
  Future<File?> compressImage(File imageFile) async {
    final filePath = imageFile.path;

    // Compress the image and get an XFile
    final XFile? compressedXFile =
        await FlutterImageCompress.compressAndGetFile(
      filePath,
      filePath.replaceFirst('.jpg',
          '_compressed.jpg'), // Specify a new name for the compressed file
      quality: 85, // Compression quality
    );

    // Convert the XFile to File and return it
    if (compressedXFile != null) {
      return File(compressedXFile.path);
    }

    return null; // Return null if compression fails
  }

  // Pick image from gallery
  Future<void> addImage() async {
    if (_images.length < 4) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You can only add up to 4 images"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Function to upload post with images to Firebase Storage and Firestore
  Future<void> postMessage() async {
    if (_post.text.isNotEmpty || _images.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      List<String> imageUrls = [];

      // Compress and upload each image to Firebase Storage
      for (var image in _images) {
        File? compressedImage = await compressImage(image);
        if (compressedImage != null) {
          String fileName =
              'posts/${DateTime.now().millisecondsSinceEpoch}_${currentUser.uid}.jpg';
          Reference ref = FirebaseStorage.instance.ref().child(fileName);
          UploadTask uploadTask =
              ref.putFile(compressedImage); // Use the compressed File
          TaskSnapshot taskSnapshot = await uploadTask;
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }
      }

      DocumentSnapshot userCred = await FirebaseFirestore.instance
          .collection("user-cred")
          .doc(currentUser.uid!)
          .get();

      // Optional: Add a delay to see the loading indicator
      await Future.delayed(Duration(seconds: 2));

      // Save post data to Firestore
      await FirebaseFirestore.instance.collection("user-posts").add({
        "UserEmail": currentUser.email,
        "pfp": profilePictureUrl,
        "username": userCred["username"],
        "post": _post.text,
        "Timestamp": Timestamp.now(),
        "Likes": [],
        "isChecked": false,
        "Images": imageUrls,
        "checkedBy": "",
      });

      // Clear after post
      _post.clear();
      setState(() {
        _images.clear();
        _isLoading = false; // Hide loading indicator
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Post is under review"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Function to remove an image
  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // if the user is logged on with a valid Gmail account
    if (_authService.isSignedInWithGoogle()) {
      var userData;
      return SafeArea(
        child:
            // Loading indicator
            _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // Design of the baseline for the create content
                          width: screenWidth * 0.96,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              width: 2,
                              color: Colors.black,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 2.5),
                              ),
                            ],
                          ),

                          // Functions inside the create content button
                          child: Column(
                            children: [
                              // Cancel and post button
                              Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                  bottom: screenHeight * 0.02,
                                  left: screenWidth * 0.02,
                                  right: screenWidth * 0.02,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Cancel button
                                    GestureDetector(
                                      // If clicked
                                      onTap: () {
                                        setState(() {
                                          _post.clear();
                                          _images.clear();
                                        });
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.red,
                                          fontSize: screenWidth * 0.035,
                                        ),
                                      ),
                                    ),

                                    // Post button
                                    GestureDetector(
                                      // If clicked
                                      onTap: postMessage,
                                      child: Container(
                                        width: screenWidth * 0.16,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 98, 147, 101),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: Offset(0, 2.5),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Post",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: screenWidth * 0.037,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Row for profile image and textfield
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Profile image
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: InstaImageViewer(
                                        child: Container(
                                          width: screenWidth * 0.09,
                                          height: screenHeight * 0.04,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              // Demo image
                                              image: profilePictureUrl != null
                                                  ? NetworkImage(
                                                      profilePictureUrl!) // Use the fetched profile picture URL
                                                  : AssetImage(
                                                          'assets/baseProfilePicture.png')
                                                      as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // TextField to insert content
                                    Container(
                                      height: _images.isNotEmpty
                                          ? screenHeight * 0.3
                                          : screenHeight * 0.45,
                                      width: screenWidth * 0.8,
                                      child: TextField(
                                        controller: _post,
                                        cursorColor: Colors.black,
                                        maxLines:
                                            null, // Allows the TextField to have unlimited lines
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.015,
                                            horizontal: screenWidth * 0.02,
                                          ),
                                          hintText: "What's on your mind?",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w900,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        keyboardType: TextInputType
                                            .multiline, // Allows multiline input
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Display selected images in a column
                              if (_images.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.all(screenHeight *
                                      0.01), // Added padding for better layout
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < _images.length; i++)
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Image.file(
                                                _images[i],
                                                height: screenHeight * 0.25,
                                                width: screenWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: () => removeImage(i),
                                                child: Container(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),

                              // Add photo button
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                    vertical: screenHeight * 0.01),
                                child: GestureDetector(
                                  onTap: addImage,
                                  child: Container(
                                    height: screenHeight * 0.055,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 98, 147, 101),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: Offset(0, 2))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo_library,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Text(
                                          "Add photo",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      );
    } else {
      return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Text(
                  "Verify your account to create a post",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    // logic implementation
                    onTap: () {
                      AuthService().signInWithGoogle(context);
                    },

                    // base for the google sign in button
                    child: Container(
                      height: screenHeight * 0.04,
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // google image
                          Image(
                            image: AssetImage(
                              "assets/google_logo-google_icongoogle-512.webp",
                            ),
                            height: screenHeight * 0.03,
                            width: screenWidth * 0.1,
                          ),

                          // sign in with google text
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.02,
                              right: screenWidth * 0.02,
                            ),
                            child: Text(
                              "Verify with Google",
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
