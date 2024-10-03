// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:majmu/screens/content/posts%20components/like_button.dart';

class PostBaseline extends StatefulWidget {
  final String post;
  final String user;
  final String postId;
  final List<String> likes;
  final bool isApproved;
  final List<String> images; // Added to hold image URLs

  const PostBaseline({
    super.key,
    required this.post,
    required this.user,
    required this.postId,
    required this.likes,
    required this.isApproved,
    required this.images, // New parameter for images
  });

  @override
  State<PostBaseline> createState() => _PostBaselineState();
}

class _PostBaselineState extends State<PostBaseline> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // bool for like button
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    // Check if the post is liked by the current user
    isLiked = widget.likes.contains(currentUser.email);
  }

  // Toggle like status for the post
  void ToggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle the like status
    });

    // Access the document in Firestore
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("user-posts").doc(widget.postId);

    if (isLiked) {
      // If the post is liked, add the current user's email to likes[]
      postRef.update({
        "Likes": FieldValue.arrayUnion(
          [currentUser.email],
        )
      });
    } else {
      // If it's unliked, remove the current user's email from likes[]
      postRef.update({
        "Likes": FieldValue.arrayRemove(
          [currentUser.email],
        )
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Check if the post has been approved or not
    if (widget.isApproved == true) {
      return Padding(
        padding: EdgeInsets.all(screenHeight * 0.01), // Uniform padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container to hold the post content
            Container(
              width: screenWidth * 0.97,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Fixed border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1), // Subtle shadow for depth
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2.5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile picture and username
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: Row(
                      children: [
                        // Profile picture with fixed size for consistency
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/ziyarah.jpg"),
                          radius: screenHeight * 0.024, // Dynamic radius
                        ),
                        SizedBox(
                            width: screenWidth *
                                0.017), // Spacing between picture and text
                        Text(
                          widget.user,
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Bold username
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Post text
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Text(
                      widget.post,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04), // Dynamic font size
                    ),
                  ),

                  // Image display section
                  if (widget.images.isNotEmpty) ...[
                    SizedBox(
                        height: screenHeight *
                            0.01), // Spacing before the image section
                    // Display images in a grid style
                    GridView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling
                      shrinkWrap: true, // Fit to the content
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (widget.images.length == 1)
                            ? 1
                            : 2, // 1 or 2 images
                        childAspectRatio: (widget.images.length == 1)
                            ? (16 / 9)
                            : 1, // Adjust aspect ratio for images
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(screenHeight *
                              0.005), // Added padding around each image
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Fixed border radius for images
                            child: Image.network(
                              widget.images[index],
                              fit: BoxFit.cover, // Cover the entire container
                            ),
                          ),
                        );
                      },
                    ),
                  ],

                  // Likes and comments section
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: Row(
                      children: [
                        // Like button component
                        LikeButton(
                          isLiked: isLiked,
                          onTap: () {
                            ToggleLike(); // Call toggle like method
                          },
                        ),
                        SizedBox(
                            width: screenWidth *
                                0.02), // Spacing between like button and count
                        Text(
                          widget.likes.length.toString(),
                          style: TextStyle(
                              color: Colors.grey), // Style for like count
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // Space between posts
          ],
        ),
      );
    } else {
      return Container(); // If the post is not approved, it won't appear
    }
  }
}
