// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:majmu/components/posts%20components/bookmark_button.dart';
import 'package:majmu/components/posts%20components/like_button.dart';
import 'package:popover/popover.dart';

class RejectedPost extends StatefulWidget {
  final String post;
  final String pfp;
  final String user;
  final String postId;
  final List<String> likes;
  final List<String> bookmarkedBy;
  final bool isChecked;
  final List<String> images; // Added to hold image URLs
  final String rejectMessage;

  const RejectedPost({
    super.key,
    required this.post,
    required this.pfp,
    required this.user,
    required this.postId,
    required this.likes,
    required this.bookmarkedBy,
    required this.isChecked,
    required this.images,
    required this.rejectMessage,
  });

  @override
  State<RejectedPost> createState() => _RejectedPostState();
}

class _RejectedPostState extends State<RejectedPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // method to delete post
  Future<void> deletePost(String postId) async {
    // Reference the collection and the post
    CollectionReference posts =
        FirebaseFirestore.instance.collection('rejected-posts');

    try {
      // Delete the post by its ID
      await posts.doc(postId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Post successfully deleted!'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      print("Post successfully deleted!");
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Check if the post has been approved or not
    if (widget.isChecked == true) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Profile picture with fixed size for consistency
                            InstaImageViewer(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget.pfp),
                                radius: screenHeight * 0.024, // Dynamic radius
                              ),
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

                        // if on ilmpage, this button wont appear
                        // button to delete post
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert_rounded),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          onSelected: (value) async {
                            if (value == 'delete') {
                              bool shouldDelete = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Delete Post",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: Text(
                                      "Are you sure you want to delete this post?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (shouldDelete) {
                                await deletePost(widget.postId);
                              }
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text(
                                    'Delete Post',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Post text
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
                            : 1.5, // Adjust aspect ratio for images
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(screenHeight *
                              0.005), // Added padding around each image
                          child: InstaImageViewer(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              // Fixed border radius for images
                              child: Image.network(
                                widget.images[index],
                                fit: BoxFit.fitWidth,
                                // Cover the entire container
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],

                  // Likes and bookmark section
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            // Like button component
                            LikeButton(
                              isLiked: false,
                              onTap: () {},
                            ),

                            Text(
                              widget.likes.length.toString(),
                              style: TextStyle(
                                  color: Colors.grey), // Style for like count
                            ),
                          ],
                        ),

                        SizedBox(
                          width: screenHeight * 0.02,
                        ),

                        // add to bookmark button
                        Column(
                          children: [
                            BookmarkButton(
                              isBookmarked: false,
                              onTap: () {},
                            ),
                            Text(
                              widget.bookmarkedBy.length.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ), // Style for like count
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // reject message
            Container(
              width: screenWidth *
                  0.95, // Slightly smaller than main post width for padding
              margin: EdgeInsets.only(
                  top: screenHeight * 0.01), // Top margin for separation
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015,
                horizontal: screenWidth * 0.04,
              ), // Added padding within the container
              decoration: BoxDecoration(
                color: Colors.red[100], // Light red background for visibility
                borderRadius: BorderRadius.circular(8), // Rounded corners
                border: Border.all(
                  color: Colors.red, // Red border for emphasis
                  width: 1.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red[700],
                    size: screenHeight * 0.025, // Responsive icon size
                  ),
                  SizedBox(
                      width:
                          screenWidth * 0.03), // Spacing between icon and text
                  Expanded(
                    child: Text(
                      "Reject Reason: ${widget.rejectMessage}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive font size
                        color: Colors.red[800], // Dark red for text visibility
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis, // Ellipsis for long messages
                    ),
                  ),
                ],
              ),
            ),

            // padding with other posts
            SizedBox(height: screenHeight * 0.01), // Space between posts
          ],
        ),
      );
    } else {
      return Container(); // If the post is not approved, it won't appear
    }
  }
}
