// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:majmu/screens/content/content%20components/content_bookmark.dart';

class ContentViewer extends StatefulWidget {
  final String path;
  final String name;

  ContentViewer({
    required this.path,
    required this.name,
  });

  @override
  State<ContentViewer> createState() => _ContentViewerState();
}

class _ContentViewerState extends State<ContentViewer> {
  // bool for bookmark button
  bool isBookmarked = false;

  // method when toggling bookmark in post
  void ToggleBookmarked() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // back button
        leading: GestureDetector(
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
                ToggleBookmarked();
              },
            ),
          ),
        ],

        title: Text(widget.name),
      ),
      body: PDFView(
        filePath: widget.path,
      ),
    );
  }
}
