// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

      // Optional: Add a delay to see the loading indicator
      await Future.delayed(Duration(seconds: 2));

      // Save post data to Firestore
      await FirebaseFirestore.instance.collection("user-posts").add({
        "UserEmail": currentUser.email,
        "post": _post.text,
        "Timestamp": Timestamp.now(),
        "Likes": [],
        "isApproved": false,
        "Images": imageUrls,
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

    return SafeArea(
      child: SingleChildScrollView(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
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
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile image
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: screenWidth * 0.09,
                            height: screenHeight * 0.04,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                // Demo image
                                image: AssetImage("assets/islamicEvents.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // TextField to insert content
                        Container(
                          height: screenHeight * 0.45,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0), // Add spacing between images
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8), // Maintain rounded corners
                                    child: Image.file(
                                      _images[i],
                                      width: screenWidth *
                                          0.9, // Ensure images are not wider than container
                                      fit: BoxFit
                                          .cover, // Maintain aspect ratio and cover the container
                                    ),
                                  ),
                                  IconButton(
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .black, // Set the background color here
                                        // Optional: Add a border
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(screenWidth *
                                            0.015), // Adjust padding as needed
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: screenWidth * 0.07,
                                        ),
                                      ),
                                    ),
                                    onPressed: () => removeImage(i),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                  // Divider for picture or location
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.black,
                    ),
                  ),

                  // Row for adding pictures
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 15),
                        child: GestureDetector(
                          onTap: addImage,
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: screenWidth * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Loading indicator
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
