// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majmu/components/private%20bookmark%20components/docscan.dart';
import 'package:majmu/components/private%20bookmark%20components/private_bookmarks.dart';

class BPrivatePage extends StatefulWidget {
  const BPrivatePage({super.key});

  @override
  State<BPrivatePage> createState() => _BPrivatePageState();
}

class _BPrivatePageState extends State<BPrivatePage> {
  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // create method to apply a blueprint for the bookmarks (public)

    // page base
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user-cred')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('privateBookmarks')
                    .orderBy("dateCreated", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(
                              color: Colors.green,
                            ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Stack(
                      children: [
                        Center(
                          child: Text(
                            'No Private Bookmarks yet, add them now :)',
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // scan new document button
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth * 0.03,
                              bottom: screenHeight * 0.01,
                            ),
                            child: DocScanButton(),
                          ),
                          right: 1,
                          bottom: 1,
                        ),
                      ],
                    );
                  }
                  return Stack(
                    children: [
                      ListView(
                        children: snapshot.data!.docs.map((doc) {
                          return PrivateBookmarks(
                            bookmarkId: doc.id,
                            fileName: doc['name'] ?? '',
                            description: doc['description'] ?? '',
                            previewImageUrl: doc['previewImageUrl'],
                            pdfUrl: doc['fileUrl'], // Update to use 'fileUrl'
                            dateCreated: doc['dateCreated'],
                          );
                        }).toList(),
                      ),

                      // scan new document button
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: screenWidth * 0.03,
                            bottom: screenHeight * 0.01,
                          ),
                          child: DocScanButton(),
                        ),
                        right: 1,
                        bottom: 1,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
