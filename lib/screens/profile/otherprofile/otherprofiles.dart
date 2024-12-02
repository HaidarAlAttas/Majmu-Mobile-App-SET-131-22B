import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:majmu/components/edit%20profile%20components/text_box.dart';
import 'package:majmu/components/edit%20profile%20components/userpfp.dart';
import 'package:majmu/components/other%20profile%20components/other_text_box.dart';
import 'package:majmu/components/posts%20components/postbaselines.dart';

class OtherProfiles extends StatefulWidget {
  final String userUid;

  const OtherProfiles({
    super.key,
    required this.userUid,
  });

  @override
  State<OtherProfiles> createState() => _OtherProfilesState();
}

class _OtherProfilesState extends State<OtherProfiles> {
  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 241, 222),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 241, 222),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("user-cred")
              .doc(widget.userUid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  SizedBox(height: screenHeight * 0.04),

                  // profile text
                  Center(
                    child: Text(
                      "P R O F I L E",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth * 0.08,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // profile picture
                  UserPfp(
                    // component
                    image: userData["profilePicture"] ??
                        AssetImage(
                            "baseProfilePicture.png"), // Handle empty profile picture case
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.2,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: InstaImageViewer(
                            child: Image.network(
                              userData["profilePicture"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // username
                  OtherTextBox(
                      text: userData["username"],
                      sectionName: "Username",
                      onTap: () {}),

                  SizedBox(height: screenHeight * 0.04),

                  // bio
                  OtherTextBox(
                      text: userData["bio"], sectionName: "Bio", onTap: () {}),

                  SizedBox(height: screenHeight * 0.04),

                  // email
                  OtherTextBox(
                      text: userData["email"],
                      sectionName: "Email",
                      onTap: () {}),

                  SizedBox(height: screenHeight * 0.04),

                  Center(
                    child: Text(
                      "User Posts",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.06,
                      ),
                    ),
                  ),

                  // the users posts
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("user-posts")
                          .where("userUid", isEqualTo: widget.userUid)
                          .orderBy("Timestamp", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final userData = snapshot.data!.docs;

                          return ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: userData.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;

                              return PostBaseline(
                                post: data["post"] ?? "",
                                pfp: data['pfp'] ?? '',
                                user: data['username'] ?? '',
                                userEmail: data['userEmail'] ?? '',
                                userUid: data['userUid'] ?? '',
                                postId: doc.id,
                                likes: (data['Likes'] as List<dynamic>? ?? [])
                                    .cast<String>(),
                                bookmarkedBy:
                                    (data['bookmarkedBy'] as List<dynamic>? ??
                                            [])
                                        .cast<String>(),
                                isChecked: data['isChecked'] ?? false,
                                images: (data['images'] as List<dynamic>? ?? [])
                                    .cast<String>(),
                                settingButton: false,
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("An error occurred: ${snapshot.error}"),
                          );
                        } else {
                          return Center(
                            child: Platform.isIOS
                                ? CupertinoActivityIndicator()
                                : CircularProgressIndicator(
                                    color: Colors.green),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("An error occurred: ${snapshot.error}"),
                ),
              );
            } else {
              return Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(
                        color: Colors.green,
                      ),
              );
            }
          },
        ),
      ),
    );
  }
}
