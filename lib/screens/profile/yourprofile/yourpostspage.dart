// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majmu/components/posts%20components/postbaselines.dart';
import 'package:majmu/components/your%20profile%20page%20component/approvalrejectionbutton.dart';
import 'package:majmu/screens/auth/googlebutton.dart';
import 'package:majmu/screens/profile/yourprofile/rejectedpost.dart';
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
    String userUid = currentUser.uid;

    // Stream for user posts where UserEmail matches current user's email
    Stream<QuerySnapshot> userPostsStream = FirebaseFirestore.instance
        .collection('user-posts')
        .where('userUid', isEqualTo: userUid)
        .orderBy("Timestamp", descending: true)
        .snapshots();

    // Stream for user rejected posts where UserEmail matches current user's email
    Stream<QuerySnapshot> userRejectedPostsStream = FirebaseFirestore.instance
        .collection('rejected-posts')
        .where('userUid', isEqualTo: userUid)
        .orderBy("Timestamp", descending: true)
        .snapshots();

    if (_authService.isSignedInWithGoogle()) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 241, 222),
        appBar: AppBar(
          // Back button
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),

          // wallpaper color
          backgroundColor: Color.fromARGB(255, 245, 241, 222),

          // title appbar
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
                ApprovalRejectionButtons(
                  approvedChoice: approvedChoice,
                  appOrRej: appOrRej,
                  onUpdate: (choice, state) {
                    setState(() {
                      approvedChoice = choice;
                      appOrRej = state;
                    });
                  },
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
                                  String postUserEmail =
                                      postData["userEmail"] ?? ["no email"];
                                  String userUid =
                                      postData["userUid"] ?? "No userUid";
                                  String postProfilePicture =
                                      postData["pfp"] ?? "";
                                  String postId = postDocs[index].id;
                                  List<String> likes = List<String>.from(
                                      postData["Likes"] ?? []);
                                  List<String> bookmarked = List<String>.from(
                                      postData["bookmarkedBy"] ?? []);
                                  bool isApproved =
                                      postData["isChecked"] ?? false;
                                  List<String> images = List<String>.from(
                                      postData["Images"] ?? []);

                                  return PostBaseline(
                                    post: postContent, // Post content
                                    pfp:
                                        postProfilePicture, // post profile picture
                                    user: postUsername, // The user who posted
                                    userEmail: postUserEmail,
                                    userUid: userUid,
                                    postId: postId, // Post ID
                                    likes: likes, // List of likes
                                    bookmarkedBy: bookmarked,
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
                                child: Platform.isIOS
                                    ? CupertinoActivityIndicator()
                                    : CircularProgressIndicator(
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
                                        "You're lucky nothing is rejected yet -__-"));
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
                                  List<String> bookmarked = List<String>.from(
                                      postData["bookmarkedBy"] ?? []);
                                  bool isApproved =
                                      postData["isChecked"] ?? false;
                                  List<String> images = List<String>.from(
                                      postData["Images"] ?? []);
                                  String rejectMessage =
                                      postData["rejectedMessage"] ??
                                          "No reject message";

                                  return RejectedPost(
                                    post: postContent, // Post content
                                    pfp:
                                        postProfilePicture, // post profile picture
                                    user: postUsername, // The user who posted
                                    postId: postId, // Post ID
                                    likes: likes, // List of likes
                                    bookmarkedBy: bookmarked,
                                    isChecked: isApproved, // Approval status
                                    images: images, // List of image URLs
                                    rejectMessage: rejectMessage,
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
                                child: Platform.isIOS
                                    ? CupertinoActivityIndicator()
                                    : CircularProgressIndicator(
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
                  GoogleButton(
                    registration: false,
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
