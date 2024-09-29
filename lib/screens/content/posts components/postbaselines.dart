// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/posts%20components/like_button.dart';

class PostBaseline extends StatefulWidget {
  final String post;
  final String user;
  final String postId;
  final List<String> likes;

  const PostBaseline({
    super.key,
    required this.post,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<PostBaseline> createState() => _PostBaselineState();
}

class _PostBaselineState extends State<PostBaseline> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // bool fo like button
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // toggle like button
  void ToggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // access the document
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("user-posts").doc(widget.postId);

    if (isLiked) {
      // if the post is liked, add into likes[]
      postRef.update({
        "Likes": FieldValue.arrayUnion(
          [currentUser.email],
        )
      });
    } else {
      // if it's unliked, remove from the likes[]
      postRef.update({
        "Likes": FieldValue.arrayRemove(
          [currentUser.email],
        )
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // method fot posts baseline

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // post baselines (post base size)
            Container(
              width: screenWidth * 0.97,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 2.5),
                  ),
                ],
              ),

              // Partitioning for the User part
              //pfp and username,
              //Content's Text,
              //Image
              //like and comment button

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // pfp and username
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      top: screenWidth * 0.02,
                      bottom: screenHeight * 0.02,
                    ),
                    child: Row(
                      children: [
                        // profile picture
                        Container(
                          width: screenWidth * 0.08,
                          height: screenHeight * 0.04,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),

                            // demo image
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/ziyarah.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // username
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Text(
                            // demo username
                            widget.user,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // text baseline
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: screenHeight * 0.02,
                        left: screenWidth * 0.02,
                        right: screenWidth * 0.02),
                    child: Text(
                      widget.post.toString(),
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.036),
                    ),
                  ),

                  // Image baseline

                  // likes and comments
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02,
                        right: screenWidth * 0.02,
                        bottom: screenHeight * 0.02),
                    child: GestureDetector(
                      // demo- need to change bila dah siap post-id so that bila like, bukan semua post akan di like
                      // if clicked
                      onTap: () {},

                      child: Row(
                        children: [
                          // like button and like count

                          Column(
                            children: [
                              // like button
                              LikeButton(
                                isLiked: isLiked,
                                onTap: () {
                                  ToggleLike();
                                },
                              ),

                              // like count
                              Text(
                                widget.likes.length.toString(),
                              ),
                            ],
                          )

                          // comment button
                        ],
                      ),
                    ),
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
