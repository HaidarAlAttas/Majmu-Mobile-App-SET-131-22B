// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class StorageAndDataPage extends StatefulWidget {
  const StorageAndDataPage({super.key});

  @override
  State<StorageAndDataPage> createState() => _StorageAndDataPageState();
}

class _StorageAndDataPageState extends State<StorageAndDataPage> {
  // method to delete data inside the app
  Future<void> deleteData(String currentUser, String collection) async {
    // Reference the "post" collection within the "user-cred" document
    CollectionReference postCollection = FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUser)
        .collection(collection);

    // Get all documents in the "post" collection
    QuerySnapshot postDocs = await postCollection.get();

    // Delete each document in the "post" collection
    for (var doc in postDocs.docs) {
      await doc.reference.delete();
    }

    // Additionally, remove the currentUser UID from the "bookmarkedBy" array in the "user-posts" collection
    CollectionReference userPosts =
        FirebaseFirestore.instance.collection("user-posts");

    // Fetch all posts where the current user's UID might exist in the "bookmarkedBy" array
    QuerySnapshot postsWithBookmarks =
        await userPosts.where("bookmarkedBy", arrayContains: currentUser).get();

    for (var postDoc in postsWithBookmarks.docs) {
      await postDoc.reference.update({
        "bookmarkedBy": FieldValue.arrayRemove([currentUser]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // back button
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title and description
              Text(
                "Manage Your Data",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "You can manage your data storage settings here. Be mindful that deleting your data will remove it permanently from the cloud storage",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              // Delete data button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            "Delete Data?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to delete all your data? This action cannot be undone.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // delete data logic
                                await deleteData(
                                    currentUser, "contentsPublicBookmark");
                                await deleteData(
                                    currentUser, "privateBookmarks");
                                await deleteData(
                                    currentUser, "postPublicBookmark");

                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Delete Data",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
