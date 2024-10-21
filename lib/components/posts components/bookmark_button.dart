// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  final void Function()? onTap; // Simplified to use VoidCallback

  BookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onTap,
  });

  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  // Method to check if the current user has liked the post
  Future<bool> fetchBookmark() async {
    QuerySnapshot userPostsSnapshot = await FirebaseFirestore.instance
        .collection('user-posts')
        .where('bookmarkedBy', arrayContains: currentUser)
        .get();

    return userPostsSnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: fetchBookmark(), // Asynchronously fetch if the post is liked
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data, display a loading indicator
          return Icon(
            Icons.bookmark_add_outlined,
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
            isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
            color: isBookmarked ? Colors.yellow[600] : Colors.grey,
          ),
        );
      },
    );
  }
}
