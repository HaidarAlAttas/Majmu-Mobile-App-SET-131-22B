// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:majmu/components/posts%20components/bookmark_button.dart';
import 'package:majmu/components/posts%20components/like_button.dart';
import 'package:popover/popover.dart';

class PostBaseline extends StatefulWidget {
  final String post;
  final String pfp;
  final String user;
  final String postId;
  final List<String> likes;
  final List<String> bookmarkedBy;
  final bool isChecked;
  final List<String> images; // Added to hold image URLs
  final bool settingButton;

  const PostBaseline({
    super.key,
    required this.post,
    required this.pfp,
    required this.user,
    required this.postId,
    required this.likes,
    required this.bookmarkedBy,
    required this.isChecked,
    required this.images,
    required this.settingButton,
  });

  @override
  State<PostBaseline> createState() => _PostBaselineState();
}

class _PostBaselineState extends State<PostBaseline> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // bool for like button
  late bool isLiked = false;

  // bool for bookmark button
  late bool isBookmarked = false;

  // bool for image
  bool imageTapped = false;

  // bool for settingbutton
  late bool settingButton;

  @override
  void initState() {
    super.initState();
    // Check if the post is liked by the current user
    isLiked = widget.likes.contains(currentUser.uid);

    // Check if the post is bookmarked by the user
    isBookmarked = widget.bookmarkedBy.contains(currentUser.uid);
    settingButton = widget.settingButton;
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
          [currentUser.uid],
        )
      });
    } else {
      // If it's unliked, remove the current user's email from likes[]
      postRef.update({
        "Likes": FieldValue.arrayRemove(
          [currentUser.uid],
        )
      });
    }
  }

  // method when toggling bookmark in post
  void ToggleBookmarked() {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    // Access the document in Firestore
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("user-posts").doc(widget.postId);

    if (isBookmarked) {
      // If the post is bookmarked, add the current user's email to likes[]
      postRef.update({
        "bookmarkedBy": FieldValue.arrayUnion(
          [currentUser.uid],
        )
      });
    } else {
      // If it's unbookmarked, remove the current user's email from likes[]
      postRef.update({
        "bookmarkedBy": FieldValue.arrayRemove(
          [currentUser.uid],
        )
      });
    }
  }

  // method to delete post
  Future<void> deletePost(String documentId) async {
    // Reference the collection and the document
    CollectionReference posts =
        FirebaseFirestore.instance.collection('user-posts');

    try {
      // Delete the document by its ID
      await posts.doc(documentId).delete();
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
                        settingButton
                            ? PopupMenuButton<String>(
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          content: Text(
                                            "Are you sure you want to delete this post?",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
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
                              )

                            // if not on your posts, it wont appear
                            : Container(),
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
                              isLiked: isLiked,
                              onTap: ToggleLike,
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
                              isBookmarked: isBookmarked,
                              onTap: ToggleBookmarked,
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
            SizedBox(height: screenHeight * 0.01), // Space between posts
          ],
        ),
      );
    } else {
      return Container(); // If the post is not approved, it won't appear
    }
  }
}
