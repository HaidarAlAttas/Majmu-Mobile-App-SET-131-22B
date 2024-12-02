// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:majmu/components/homepage%20components/content_bookmark.dart';

class ContentViewer extends StatefulWidget {
  final String path;
  final String name;
  final Reference fileReference;

  ContentViewer({
    required this.path,
    required this.name,
    required this.fileReference,
  });

  @override
  State<ContentViewer> createState() => _ContentViewerState();
}

class _ContentViewerState extends State<ContentViewer> {
  // bool for bookmark button
  bool isBookmarked = false;

  // fetch current user using the app
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  // kena tambah function to make the bookmark stays kuning if bukak balik content viewer (rujuk post baseline)
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fetch bookmark status if already bookmarked, it will stay true
    fetchBookmarkStatus();
  }

  // Method to fetch bookmark status from Firestore
  void fetchBookmarkStatus() async {
    DocumentSnapshot bookmarkSnapshot = await FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUser)
        .collection("contentsPublicBookmark")
        .doc(widget.name)
        .get();

    // Check if the document exists
    if (bookmarkSnapshot.exists) {
      setState(() {
        isBookmarked = true; // If document exists, set isBookmarked to true
      });
    } else {
      setState(() {
        isBookmarked =
            false; // If document doesn't exist, set isBookmarked to false
      });
    }
  }

  // method when toggling bookmark in post
  void ToggleBookmarked(Reference ref) async {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    if (isBookmarked == true) {
      // Fetch the download URL from Firebase Storage
      final downloadURL = await ref.getDownloadURL();

      // Save the Firebase Storage download URL in Firestore instead of the local path
      await FirebaseFirestore.instance
          .collection("user-cred")
          .doc(currentUser)
          .collection("contentsPublicBookmark")
          .doc(widget.name)
          .set({
        "filePath": downloadURL, // Use Firebase Storage URL here
        "isBookmarked": true,
        "Timestamp": Timestamp.now(),
      });
    } else {
      await FirebaseFirestore.instance
          .collection("user-cred")
          .doc(currentUser)
          .collection("contentsPublicBookmark")
          .doc(widget.name)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // back button
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.03),
            // call button component in content components
            child: ContentBookmarkButton(
              isBookmarked: isBookmarked,
              onTap: () {
                ToggleBookmarked(
                  widget.fileReference,
                );
              },
            ),
          ),
        ],

        title: Text(
          widget.name.contains("_")
              ? widget.name.split('_').sublist(1).join('_')
              : widget.name,
        ),
      ),
      body: PDFView(
        filePath: widget.path,
      ),
    );
  }
}
