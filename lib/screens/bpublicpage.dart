// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  bool publicChoice = true;
  int puborpriv = 0; // State to determine if public or private content is shown

  // Fetch current user ID
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;

  // Variable for bookmarks
  late Future<List<Map<String, dynamic>>> futureBookmarks;

  @override
  void initState() {
    super.initState();
    futureBookmarks = fetchBookmarks(); // Initialize future bookmarks on start
  }

  // Fetch bookmarks from Firestore
  Future<List<Map<String, dynamic>>> fetchBookmarks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUser)
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
    final dir = await getDownloadsDirectory();
    final localFilePath =
        '${dir!.path}/$fileName.pdf'; // Local file path for download

    try {
      final downloadURL = await ref.getDownloadURL(); // Get the download URL
      await Dio().download(downloadURL, localFilePath); // Download the PDF

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
      print("Error while downloading the PDF: $e"); // Handle download error
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Container for public and private bookmark navigator
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.03,
                ),
                child: Container(
                  height: screenHeight * 0.047,
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.032),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Public button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            publicChoice = true; // Set public choice
                            puborpriv = 0; // Set state to public
                          });
                        },
                        child: Container(
                          height: screenHeight * 0.035,
                          width: screenWidth * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: publicChoice
                                ? Colors.black
                                : Colors
                                    .white, // Change color based on selection
                          ),
                          child: Center(
                            child: Text(
                              "Public",
                              style: TextStyle(
                                color: publicChoice
                                    ? Colors.white
                                    : Colors
                                        .black, // Change text color based on selection
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Private button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            publicChoice = false; // Set private choice
                            puborpriv = 1; // Set state to private
                          });
                        },
                        child: Container(
                          height: screenHeight * 0.035,
                          width: screenWidth * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: publicChoice
                                ? Colors.white
                                : Colors
                                    .black, // Change color based on selection
                          ),
                          child: Center(
                            child: Text(
                              "Private",
                              style: TextStyle(
                                color: publicChoice
                                    ? Colors.black
                                    : Colors
                                        .white, // Change text color based on selection
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Conditional display of bookmarks or private page
              Expanded(
                child: puborpriv == 0
                    ? SingleChildScrollView(
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: futureBookmarks,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // Loading state
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'Error: ${snapshot.error}')); // Error handling
                            }

                            final bookmarks = snapshot.data;

                            if (bookmarks == null || bookmarks.isEmpty) {
                              return Center(
                                  child: Text(
                                      'No bookmarks yet, add them now!')); // No bookmarks message
                            }

                            return ListView.builder(
                              shrinkWrap:
                                  true, // ListView takes only needed space
                              itemCount: bookmarks.length,
                              itemBuilder: (context, index) {
                                final bookmark = bookmarks[index];
                                return GestureDetector(
                                  onTap: () async {
                                    openPDF(context, bookmark["path"],
                                        bookmark["name"]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            bookmark[
                                                "name"], // Display the folder name
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon:
                                              Icon(Icons.navigate_next_rounded),
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
                        ),
                      )
                    : BPrivatePage(), // Render private page if selected
              ),
            ],
          ),
        ),
      ),
    );
  }
}
