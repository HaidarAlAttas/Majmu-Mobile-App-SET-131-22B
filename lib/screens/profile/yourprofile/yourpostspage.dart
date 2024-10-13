// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/posts%20components/postbaselines.dart';
import 'package:majmu/services/auth_service.dart';

class YourPostsPage extends StatefulWidget {
  const YourPostsPage({super.key});

  @override
  State<YourPostsPage> createState() => _YourPostsPageState();
}

class _YourPostsPageState extends State<YourPostsPage> {
  // check if the user is logged with a valid Gmail account
  final AuthService _authService = AuthService();

  // variable for the approve and rejected button
  final Color whiteColor;
  final Color blackColor;
  bool approvedChoice = true;
  bool rejectedChoice = true;
  int i = 0;

  // state to change page from approve to private
  int appOrRej = 0;

  _YourPostsPageState({
    this.whiteColor = Colors.white,
    this.blackColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current user
    final currentUser = FirebaseAuth.instance.currentUser;

    // Get screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Check if user is logged in
    if (currentUser == null) {
      return Scaffold(
        body: Center(child: Text("No user is logged in")),
      );
    }

    // Get the user's email
    String userEmail = currentUser.email!;

    // Stream for user posts where UserEmail matches current user's email
    Stream<QuerySnapshot> userPostsStream = FirebaseFirestore.instance
        .collection('user-posts')
        .where('UserEmail', isEqualTo: userEmail)
        .snapshots();

    // Stream for user rejected posts where UserEmail matches current user's email
    Stream<QuerySnapshot> userRejectedPostsStream = FirebaseFirestore.instance
        .collection('rejected-posts')
        .where('UserEmail', isEqualTo: userEmail)
        .snapshots();

    if (_authService.isSignedInWithGoogle()) {
      return Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 131, 157, 132),
          title: Text(
            'Your Posts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // button to change from approved posts to rejected posts
                // container for approved and rejected navigator
                Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.03,
                      left: screenWidth * 0.03,
                      bottom: screenHeight * 0.03),
                  child: Container(
                    height: screenHeight * 0.047,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    // button for approved and rejected bookmark
                    child: Row(
                      children: [
                        // approved button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // to change the color of the button when clicked
                              approvedChoice = true;
                              rejectedChoice = true;
                              appOrRej = 0;
                              // get the approved bookmark
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.02,
                                right: screenWidth * 0.01),
                            child: Container(
                              height: screenHeight * 0.035,
                              width: screenWidth * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),

                                // conditional statement for the button color
                                color: approvedChoice == true
                                    ? blackColor
                                    : whiteColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Approved",
                                  style: TextStyle(

                                      // conditional statement for the text in the button color
                                      color: approvedChoice == false
                                          ? blackColor
                                          : whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // rejected post button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              approvedChoice = false;
                              rejectedChoice = false;
                              appOrRej = 1;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.02,
                                right: screenWidth * 0.01),
                            child: Container(
                              height: screenHeight * 0.035,
                              width: screenWidth * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),

                                // conditional statement for the button color
                                color: approvedChoice == false
                                    ? blackColor
                                    : whiteColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Rejected",
                                  style: TextStyle(

                                      // conditional statement for the text in the button color
                                      color: approvedChoice == true
                                          ? blackColor
                                          : whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                appOrRej == 0
                    ? Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          // Listen to Firestore collection for real-time updates
                          stream: userPostsStream,
                          builder: (context, snapshots) {
                            // If the stream has data, display the list of posts
                            if (snapshots.hasData) {
                              var postDocs = snapshots.data!.docs;

                              // Check if there are any posts
                              if (postDocs.isEmpty) {
                                return Center(
                                    child: Text(
                                        "You haven't posted anything yet, start now :)"));
                              }

                              return ListView.builder(
                                itemCount: postDocs.length,
                                itemBuilder: (context, index) {
                                  var postData = postDocs[index].data()
                                      as Map<String, dynamic>;

                                  // Extracting post fields safely
                                  String postContent =
                                      postData["post"] ?? "No content";
                                  String postUsername =
                                      postData["username"] ?? "No user";
                                  String postProfilePicture =
                                      postData["pfp"] ?? "";
                                  String postId = postDocs[index].id;
                                  List<String> likes = List<String>.from(
                                      postData["Likes"] ?? []);
                                  bool isApproved =
                                      postData["isChecked"] ?? false;
                                  List<String> images = List<String>.from(
                                      postData["Images"] ?? []);

                                  return PostBaseline(
                                    post: postContent, // Post content
                                    pfp:
                                        postProfilePicture, // post profile picture
                                    user: postUsername, // The user who posted
                                    postId: postId, // Post ID
                                    likes: likes, // List of likes
                                    isChecked: isApproved, // Approval status
                                    images: images, // List of image URLs
                                    settingButton: true,
                                  );
                                },
                              );
                            }
                            // If there is an error in the stream
                            else if (snapshots.hasError) {
                              return Center(
                                child: Text(
                                    "Error: ${snapshots.error.toString()}"),
                              );
                            }
                            // Show loading indicator while waiting for data
                            else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              );
                            }
                          },
                        ),
                      )
                    :

                    // rejected post page
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          // Listen to Firestore collection for real-time updates
                          stream: userRejectedPostsStream,
                          builder: (context, snapshots) {
                            // If the stream has data, display the list of posts
                            if (snapshots.hasData) {
                              var postDocs = snapshots.data!.docs;

                              // Check if there are any posts
                              if (postDocs.isEmpty) {
                                return Center(
                                    child: Text(
                                        "You haven't posted anything yet, start now :)"));
                              }

                              return ListView.builder(
                                itemCount: postDocs.length,
                                itemBuilder: (context, index) {
                                  var postData = postDocs[index].data()
                                      as Map<String, dynamic>;

                                  // Extracting post fields safely
                                  String postContent =
                                      postData["post"] ?? "No content";
                                  String postProfilePicture =
                                      postData["pfp"] ?? "";
                                  String postUsername =
                                      postData["username"] ?? "No user";
                                  String postId = postDocs[index].id;
                                  List<String> likes = List<String>.from(
                                      postData["Likes"] ?? []);
                                  bool isApproved =
                                      postData["isChecked"] ?? false;
                                  List<String> images = List<String>.from(
                                      postData["Images"] ?? []);

                                  return PostBaseline(
                                    post: postContent, // Post content
                                    pfp:
                                        postProfilePicture, // post profile picture
                                    user: postUsername, // The user who posted
                                    postId: postId, // Post ID
                                    likes: likes, // List of likes
                                    isChecked: isApproved, // Approval status
                                    images: images, // List of image URLs
                                    settingButton: true,
                                  );
                                },
                              );
                            }
                            // If there is an error in the stream
                            else if (snapshots.hasError) {
                              return Center(
                                child: Text(
                                    "Error: ${snapshots.error.toString()}"),
                              );
                            }
                            // Show loading indicator while waiting for data
                            else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              );
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 131, 157, 132),
          title: Text(
            'Your Posts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.green[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Text(
                      "Verify your account to create a post",
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
          ),
        ),
      );
    }
  }
}
