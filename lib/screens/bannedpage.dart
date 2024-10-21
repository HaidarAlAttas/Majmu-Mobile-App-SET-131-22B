// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannedPage extends StatefulWidget {
  const BannedPage({super.key});

  @override
  State<BannedPage> createState() => _BannedPageState();
}

class _BannedPageState extends State<BannedPage> {
  void _sendEmail() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot docField = await FirebaseFirestore.instance
          .collection("user-cred")
          .doc(currentUser.uid)
          .get();

      if (docField.exists) {
        String adminEmail = docField.get('bannedBy') ?? 'admin@example.com';
        String username = docField.get('username') ?? 'Unknown User';

        final String emailUri =
            'mailto:$adminEmail?subject=Account%20Ban%20Appeal%20for%20account%20id:%20${currentUser.uid},%20with%20username:%20$username';

        // Check if the email app can be launched
        if (await canLaunchUrlString(emailUri)) {
          try {
            await launchUrlString(emailUri);
          } catch (e) {
            print("Could not launch email client: $e");
          }
        } else {
          print("Could not launch email client");
        }
      } else {
        print('Document does not exist');
      }
    } else {
      print("User is not logged in");
    }
  }

  Future<String> banMessage() async {
    // fetch the currentuser email and username
    final currentUser = FirebaseAuth.instance.currentUser;

    DocumentSnapshot docField = await FirebaseFirestore.instance
        .collection("user-cred")
        .doc(currentUser!.uid)
        .get();

    return docField["banReason"].toString();
  }

  @override
  Widget build(BuildContext context) {
    // to create accurate sizing of the phone size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/loginbackground.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // text stating the ban
                  Text(
                    "Your account is banned from using this application",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.04),
                  ),

                  // distance
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),

                  // Button to email admin for consulation
                  GestureDetector(
                    onTap: _sendEmail,
                    child: Container(
                      height: screenHeight * 0.04,
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          // email logo
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02),
                            child: Image(
                              image: AssetImage(
                                "assets/gmailLogo.png",
                              ),
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.07,
                            ),
                          ),

                          // email text
                          Text(
                            "send email to admin",
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
