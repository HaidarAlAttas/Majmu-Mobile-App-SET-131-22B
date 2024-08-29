// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers, non_constant_identifier_names, body_might_complete_normally_nullable

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
  final double buttonWidth;
  final double buttonHeight;
  final Color whiteColor;
  final Color blackColor;
  bool publicChoice = true;
  bool privateChoice = true;
  int i = 0;

  // state to change page from public to private
  int puborpriv = 0;

  _BPublicPageState({
    this.buttonWidth = 185,
    this.buttonHeight = 30,
    this.whiteColor = Colors.white,
    this.blackColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {


    // create method to apply a blueprint for the bookmarks (public)
    Widget PublicBContent() {


      return GestureDetector(

        // detect input
        onTap: () {
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 15),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 201, 218, 162),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                // content name
                Text(
                  "Surah Ad-Dhuha",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(

                      // conditional statement for the text in the button color
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      ),
                      
                ),

                // icon to go to the content file (>)
                Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.black,
                    size: 35,
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
      // body
      body: Center(
        child: Container(
          child: Column(
            children: [
              // container for public and private bookmark navigator
              Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            height: buttonHeight,
                            width: buttonWidth,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            height: buttonHeight,
                            width: buttonWidth,
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
              puborpriv == 0

              // bila dah dapat all content, buat ListView widget kat sini
                  ? PublicBContent()

                  // if private clicked
                  : BPrivatePage(),
            ],
          ),
        ),

        // home page
      ),
    );
  }
}
