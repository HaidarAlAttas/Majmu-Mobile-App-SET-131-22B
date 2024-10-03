// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/posts%20components/postbaselines.dart';

// The main page to display all user posts
class IlmPage extends StatefulWidget {
  const IlmPage({super.key});

  @override
  State<IlmPage> createState() => _IlmPageState();
}

class _IlmPageState extends State<IlmPage> {
  @override
  Widget build(BuildContext context) {
    // Get current user
    final currentUser = FirebaseAuth.instance.currentUser!;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                        isApproved:
                            post["isApproved"], // Approval status of the post
                        images: List<String>.from(
                            post["Images"] ?? []), // List of image URLs
                      );
                    },
                  );
                } else if (snapshots.hasError) {
                  return Center(
                    child: Text("Error: " + snapshots.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(), // Loading indicator
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
