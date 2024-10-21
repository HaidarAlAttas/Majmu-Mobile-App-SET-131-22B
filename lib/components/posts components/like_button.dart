// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final void Function()? onTap;

  LikeButton({
    super.key,
    required this.isLiked,
    required this.onTap,
  });

  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  // Method to check if the current user has liked the post
  Future<bool> fetchLike() async {
    QuerySnapshot userPostsSnapshot = await FirebaseFirestore.instance
        .collection('user-posts')
        .where('Likes', arrayContains: currentUser)
        .get();

    return userPostsSnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: fetchLike(), // Asynchronously fetch if the post is liked
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data, display a loading indicator
          return Icon(
            Icons.favorite_border_outlined,
            color: Colors.grey,
          );
        }

        if (snapshot.hasError) {
          // Handle any error that occurred
          return Icon(
            Icons.error,
            color: Colors.red,
          );
        }

        return GestureDetector(
          onTap: onTap,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
