// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/camerascan.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  // post input
  final _post = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void postMessage() {
    // only posts if there is something in the textfield
    if (_post.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("user-posts").add({
        "UserEmail": currentUser.email,
        "post": _post.text,
        "Timestamp": Timestamp.now(),
        "Likes": [],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final currentUser = FirebaseAuth.instance.currentUser!;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // design of the baseline for the create content
            width: screenWidth * 0.96,
            height: screenHeight * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 2.5),
                ),
              ],
            ),

            // functions inside the create content button
            child: Column(
              children: [
                // cancel and post button
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    bottom: screenHeight * 0.02,
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // cancel button
                      GestureDetector(
                        // if clicked
                        onTap: () {
                          setState(() {
                            _post.clear();
                          });
                        },

                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.red,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),

                      // Post button
                      GestureDetector(
                        // if clicked
                        onTap: () {
                          postMessage();
                          _post.clear();
                        },
                        child: Container(
                          width: screenWidth * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 2.5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: screenWidth * 0.037,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // row for profile image and textfield
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // profile image
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: screenWidth * 0.09,
                          height: screenHeight * 0.04,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(

                                  // demo image
                                  image: AssetImage("assets/islamicEvents.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),

                      // textfield to insert content
                      Container(
                        height: screenHeight * 0.45,
                        width: screenWidth * 0.8,
                        child: TextField(
                          // controller
                          controller: _post,

                          // cursor color
                          cursorColor: Colors.black,

                          // no maxline
                          maxLines:
                              null, // Allows the TextField to have unlimited lines

                          // distance between borders and the input
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenWidth * 0.02,
                            ),

                            // hint text configuration
                            hintText: "What's on your mind?",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),

                            // remove lines on textfield
                            border: InputBorder.none,
                          ),

                          // input configuration
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType:
                              TextInputType.multiline, // Allows multiline input
                        ),
                      ),
                    ],
                  ),
                ),

                // to insert picture or location
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          border: Border(
                            // to make one line on the top of container
                            top: BorderSide(width: 2, color: Colors.black),
                          ),
                        ),

                        // content under the line (photos and locations)
                        child: Row(
                          children: [
                            GestureDetector(
                              // to display the photos (create by 25/8)
                              onTap: () {
                                setState(() {
                                  Navigator.pushNamed(context, "/camerascan");
                                });
                              },

                              // photo icon
                              child: Icon(
                                Icons.photo_size_select_actual_rounded,
                                size: screenWidth * 0.08,
                              ),
                            ),
                            GestureDetector(
                              // to display the location (create by 25/8)
                              onTap: () {
                                setState(() {});
                              },

                              // location icon
                              child: Icon(
                                Icons.add_location_alt_rounded,
                                size: screenWidth * 0.08,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
