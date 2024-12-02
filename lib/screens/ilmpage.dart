// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/testing.dart';
import 'package:majmu/components/posts%20components/postbaselines.dart';
import 'package:majmu/screens/auth/googlebutton.dart';
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
            // text for Ilm page
            // Center(
            //   child: Text(
            //     "Ilm Page",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold, fontSize: screenWidth * 0.07),
            //   ),
            // ),

            // Ilm Posts
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
                          pfp: post["pfp"],
                          user: post["username"], // The user who posted\

                          userEmail: post["userEmail"] ?? ["no email"],
                          userUid: post["userUid"],
                          postId: post.id, // Unique ID of the post
                          likes: List<String>.from(
                              post["Likes"] ?? []), // List of likes
                          bookmarkedBy:
                              List<String>.from(post["bookmarkedBy"] ?? []),
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
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(
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
              GoogleButton(
                registration: false,
              ),
            ],
          ),
        ),
      );
    }
  }
}
