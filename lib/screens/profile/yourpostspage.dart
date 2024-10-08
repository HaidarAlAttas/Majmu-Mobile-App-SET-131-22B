// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/posts%20components/postbaselines.dart';

class YourPostsPage extends StatefulWidget {
  const YourPostsPage({super.key});

  @override
  State<YourPostsPage> createState() => _YourPostsPageState();
}

class _YourPostsPageState extends State<YourPostsPage> {
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
              Expanded(
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
                          var postData =
                              postDocs[index].data() as Map<String, dynamic>;

                          // Extracting post fields safely
                          String postContent = postData["post"] ?? "No content";
                          String postUserEmail =
                              postData["UserEmail"] ?? "No user";
                          String postId = postDocs[index].id;
                          List<String> likes =
                              List<String>.from(postData["Likes"] ?? []);
                          bool isApproved = postData["isApproved"] ?? false;
                          List<String> images =
                              List<String>.from(postData["Images"] ?? []);

                          return PostBaseline(
                            post: postContent, // Post content
                            user: postUserEmail, // The user who posted
                            postId: postId, // Post ID
                            likes: likes, // List of likes
                            isApproved: isApproved, // Approval status
                            images: images, // List of image URLs
                          );
                        },
                      );
                    }
                    // If there is an error in the stream
                    else if (snapshots.hasError) {
                      return Center(
                        child: Text("Error: ${snapshots.error.toString()}"),
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
  }
}
