// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers, non_constant_identifier_names, body_might_complete_normally_nullable, unused_element

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

class BPublicPage extends StatefulWidget {
  const BPublicPage({super.key});

  @override
  State<BPublicPage> createState() => _BPublicPageState();
}

class _BPublicPageState extends State<BPublicPage> {
  // variable for the public and private button
  final Color whiteColor;
  final Color blackColor;
  bool publicChoice = true;
  bool privateChoice = true;
  int i = 0;

  // state to change page from public to private
  int puborpriv = 0;

  _BPublicPageState({
    this.whiteColor = Colors.white,
    this.blackColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // create method to apply a blueprint for the bookmarks (public)
    Widget PublicBContent() {
      return GestureDetector(
        // detect input
        onTap: () {
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.only(
              right: screenWidth * 0.03,
              left: screenWidth * 0.03,
              bottom: screenHeight * 0.01),
          child: Container(
            padding: EdgeInsets.all(10),
            height: screenHeight * 0.073,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 201, 218, 162),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // demo content name
                Text(
                  "Surah Ad-Dhuha",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // conditional statement for the text in the button color
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),

                // icon to go to the content file (>)
                Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.black,
                    size: screenWidth * 0.089,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      // body of the page
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                // container for public and private bookmark navigator
                Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.03,
                      left: screenWidth * 0.03,
                      bottom: screenHeight * 0.03),
                  child: Container(
                    height: screenHeight * 0.047,
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

                    // button for public and private bookmark
                    child: Row(
                      children: [
                        // public button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // to change the color of the button when clicked
                              publicChoice = true;
                              privateChoice = true;
                              puborpriv = 0;
                              // get the public bookmark
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.02,
                                right: screenWidth * 0.01),
                            child: Container(
                              height: screenHeight * 0.035,
                              width: screenWidth * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),

                                // conditional statement for the button color
                                color: publicChoice == true
                                    ? blackColor
                                    : whiteColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Public",
                                  style: TextStyle(

                                      // conditional statement for the text in the button color
                                      color: publicChoice == false
                                          ? blackColor
                                          : whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // private button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              publicChoice = false;
                              privateChoice = false;
                              puborpriv = 1;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.02,
                                right: screenWidth * 0.01),
                            child: Container(
                              height: screenHeight * 0.035,
                              width: screenWidth * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),

                                // conditional statement for the button color
                                color: publicChoice == false
                                    ? blackColor
                                    : whiteColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Private",
                                  style: TextStyle(

                                      // conditional statement for the text in the button color
                                      color: publicChoice == true
                                          ? blackColor
                                          : whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // conditional statement to change from public to private bookmark
                // if public clicked
                Expanded(
                  child: puborpriv == 0

                      // bila dah dapat all content, buat ListView widget kat sini
                      ? Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(1, (index) {
                                return PublicBContent();
                              }),
                            ),
                          ),
                        )

                      // if private clicked
                      : BPrivatePage(),
                ),
              ],
            ),
          ),

          // home page
        ),
      ),
    );
  }
}
