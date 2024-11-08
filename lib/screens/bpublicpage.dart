// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/components/bookmarkpages%20components/navigator2_bookmark.dart';
import 'package:majmu/components/bookmarkpages%20components/navigator_bookmark.dart';
import 'package:majmu/components/posts%20components/postbaselines.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';

class BPublicPage extends StatefulWidget {
  const BPublicPage({super.key});

  @override
  State<BPublicPage> createState() => _BPublicPageState();
}

class _BPublicPageState extends State<BPublicPage> {
  // Variable for public/private button state
  late bool publicChoice = true;
  late int puborpriv =
      0; // State to determine if public or private content is shown

  //
  late bool contentChoice = true;

  //
  late int contentOrPost = 0;

  // Fetch current user ID
  final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  // Variable for bookmarks
  late Future<List<Map<String, dynamic>>> futureContentBookmarks =
      fetchContentBookmarks();

  // Access the document in Firestore
  DocumentReference postRef =
      FirebaseFirestore.instance.collection("user-posts").doc();

  // Fetch homepage/ content bookmarks from Firestore
  Future<List<Map<String, dynamic>>> fetchContentBookmarks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUserUid)
        .collection("contentsPublicBookmark")
        .orderBy(
          "Timestamp",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map((doc) => {"name": doc.id, "path": doc["filePath"]})
        .toList();
  }

  // Method to open PDF
  Future<void> openPDF(
      BuildContext context, String filePath, String fileName) async {
    final Reference ref = FirebaseStorage.instance
        .refFromURL(filePath); // Create Reference from URL
    final dir = await getTemporaryDirectory(); // Use temporary directory
    final localFilePath =
        '${dir.path}/$fileName.pdf'; // Local file path for download

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog manually
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ), // Loading spinner
        );
      },
    );

    try {
      final downloadURL = await ref.getDownloadURL(); // Get the download URL
      await Dio().download(downloadURL, localFilePath); // Download the PDF

      // Hide loading indicator
      Navigator.pop(context);

      // Navigate to content viewer after download
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContentViewer(
            path: localFilePath,
            name: fileName,
            fileReference: ref,
          ),
        ),
      );
    } catch (e) {
      // Hide loading indicator in case of an error
      Navigator.pop(context);

      print(
          "Error while downloading the PDF: please contact the admin in setting page"); // Handle download error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error downloading PDF: please contact the admin in setting page')),
      );
    }
  }

  // method to return name for surah and juz by removing the "_" but if there's no such thing, will return the normal file name
  String getName(String fileName) {
    if (fileName.contains("_")) {
      return fileName.split('_').sublist(1).join('_');
    }
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    // to create accurate sizing of the phone size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Container for public and private bookmark navigator
            NavigatorBookmark(
              onUpdate: (bool newChoice, int newPubOrPriv) {
                setState(() {
                  publicChoice = newChoice;
                  puborpriv = newPubOrPriv;
                });
              },
              publicChoice: publicChoice,
              puborpriv: puborpriv,
            ),

            // Conditional display of bookmarks or private page
            Expanded(
              child: puborpriv == 0
                  ? Column(
                      children: [
                        Navigator2Bookmark(
                          contentChoice: contentChoice,
                          contentOrPost: contentOrPost,
                          onUpdate:
                              (bool newContentChoice, int newContentOrPost) {
                            setState(() {
                              contentChoice = newContentChoice;
                              contentOrPost = newContentOrPost;
                            });
                          },
                        ),
                        // Use Expanded to allow proper scrolling
                        Expanded(
                          child: contentOrPost == 0
                              ? FutureBuilder<List<Map<String, dynamic>>>(
                                  future: futureContentBookmarks,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                      ); // Loading state
                                    }

                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      ); // Error handling
                                    }

                                    final bookmarks = snapshot.data;

                                    if (bookmarks == null ||
                                        bookmarks.isEmpty) {
                                      return Center(
                                        child: Text(
                                            'No bookmarks yet, add them now!'),
                                      ); // No bookmarks message
                                    }

                                    return ListView.builder(
                                      itemCount: bookmarks.length,
                                      itemBuilder: (context, index) {
                                        final bookmark = bookmarks[index];
                                        return GestureDetector(
                                          onTap: () async {
                                            openPDF(
                                              context,
                                              bookmark["path"],
                                              bookmark["name"],
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            margin: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 16.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    getName(bookmark["name"]),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .navigate_next_rounded),
                                                  onPressed: () async {
                                                    await openPDF(
                                                        context,
                                                        bookmark["path"],
                                                        bookmark["name"]);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              : StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('user-posts')
                                      .where('bookmarkedBy',
                                          arrayContains: currentUserUid)
                                      .snapshots(), // Listen for real-time updates
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                      ); // Loading state
                                    }

                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      ); // Error handling
                                    }

                                    final postBookmarks =
                                        snapshot.data?.docs ?? [];

                                    if (postBookmarks.isEmpty) {
                                      return Center(
                                        child: Text(
                                            'No bookmarks yet, add them now!'),
                                      ); // No bookmarks message
                                    }

                                    return ListView.builder(
                                      itemCount: postBookmarks.length,
                                      itemBuilder: (context, index) {
                                        final post = postBookmarks[index];

                                        return KeyedSubtree(
                                          key: Key(post
                                              .id), // Assign a unique key to each post
                                          child: PostBaseline(
                                            post: post["post"],
                                            pfp: post["pfp"],
                                            user: post["username"],
                                            postId: post.id,
                                            likes: List<String>.from(
                                                post["Likes"] ?? []),
                                            bookmarkedBy: List<String>.from(
                                                post["bookmarkedBy"] ?? []),
                                            isChecked: post["isChecked"],
                                            images: List<String>.from(
                                                post["Images"] ?? []),
                                            settingButton: false,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    )
                  : BPrivatePage(), // Render private page if selected
            ),
          ],
        ),
      ),
    );
  }
}
