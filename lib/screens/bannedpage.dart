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
        // Use docField.data() to get the map and handle missing fields
        // Use the null-aware operator or explicitly check for null
        String adminEmail =
            (docField.get('bannedBy') as String?)?.isNotEmpty == true
                ? docField.get('bannedBy')
                : 'sunnahorigin@gmail.com';
        String username = docField.get('username') ?? 'Unknown User';

        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: adminEmail,
          query:
              'subject=Account%20Ban%20Appeal%20for%20account%20id:%20${currentUser.uid},%20with%20username:%20$username&body=Reason%20for%20Appealing:%0A%0A',
        );

        // Check if the email app can be launched
        if (await canLaunchUrl(emailUri)) {
          try {
            await launchUrl(emailUri);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Could not launch email:\nIf the issue persists, please contact our admin through this email: sunnahorigin@gmail.com"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 7),
              ),
            );
            print("Could not launch email client: $e");
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Could not launch email:\nIf the issue persists, please contact our admin through this email: sunnahorigin@gmail.com"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 7),
            ),
          );
          print("Could not launch email");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Document does not exist"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
        print('Document does not exist');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User is not logged in"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // text stating the ban
                  Text(
                    "Your account has been banned from using this application",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.01,
                  ),

                  // Ban reason display using FutureBuilder
                  FutureBuilder<String>(
                    future: banMessage(), // Call the asynchronous method here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          "Fetching ban reason...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error fetching ban reason.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Text(
                          "Ban reason: ${snapshot.data}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return Text(
                          "Ban reason not available.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        );
                      }
                    },
                  ),

                  // distance
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),

                  // Button to email admin for consulation
                  GestureDetector(
                    onTap: _sendEmail,
                    child: Container(
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // email logo
                          Image(
                            image: AssetImage(
                              "assets/gmailLogo.png",
                            ),
                            height: screenHeight * 0.07,
                            width: screenWidth * 0.07,
                          ),

                          // email text
                          Text(
                            "Send appeal to admin",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                            ),
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
