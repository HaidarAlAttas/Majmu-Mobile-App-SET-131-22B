// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/testing.dart';
import 'package:majmu/screens/content/posts%20components/postbaselines.dart';
import 'package:majmu/services/auth_service.dart';

// The main page to display all user posts
class IlmPage extends StatefulWidget {
  const IlmPage({super.key});

  @override
  State<IlmPage> createState() => _IlmPageState();
}

class _IlmPageState extends State<IlmPage> {
  // to check whether the user has logged on with a valid Gmail account
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Get current user
    final currentUser = FirebaseAuth.instance.currentUser!;

    // Get screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_authService.isSignedInWithGoogle()) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Ilm Page",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: screenWidth * 0.07),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // Listen to Firestore collection for real-time updates
                stream: FirebaseFirestore.instance
                    .collection("user-posts")
                    .orderBy("Timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshots.data!.docs[index];
                        return PostBaseline(
                          post: post["post"], // The content of the post
                          user: post["UserEmail"], // The user who posted
                          postId: post.id, // Unique ID of the post
                          likes: List<String>.from(
                              post["Likes"] ?? []), // List of likes
                          isChecked:
                              post["isChecked"], // Approval status of the post
                          images: List<String>.from(
                              post["Images"] ?? []), // List of image URLs
                          settingButton: false,
                        );
                      },
                    );
                  } else if (snapshots.hasError) {
                    return Center(
                      child: Text("Error: " + snapshots.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ), // Loading indicator
                    );
                  }
                },
              ),
            ),
          ],
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
                  "Verify your account to use the Ilm feature",
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
