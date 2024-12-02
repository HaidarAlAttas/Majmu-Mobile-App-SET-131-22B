// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unused_import, avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/profilepage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui'; // Import this for BackdropFilter and ImageFilter

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variable for changing pages on bottomnavbar
  int currentIndex;

  // variable for the content buttons
  final double strokeWidth;
  final double borderRadius;

  _HomePageState({
    this.currentIndex = 0,
    this.strokeWidth = 4,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Attribute for wallpaper
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white, // Starts with white at the top
            const Color.fromRGBO(
                204, 233, 205, 1), // Light green in the upper middle
            const Color.fromARGB(
                255, 167, 192, 168), // Medium green towards the bottom
            const Color.fromARGB(
                255, 118, 140, 119), // Darker green at the bottom
          ],
          begin: Alignment.topCenter, // Gradient starts from the top
          end: Alignment.bottomCenter, // Gradient ends at the bottom
          stops: [0.1, 0.4, 0.7, 1.0], // Controls how the colors transition
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          // majmu' logo
          toolbarHeight: screenHeight * 0.10,
          backgroundColor: Colors.transparent,
          title: Center(
            // when click the majmu' logo, it will go back to the home page
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: Image(
                image: AssetImage("assets/Majmu'.png"),
                height: screenHeight * 0.1,
                width: screenWidth * 0.17,
              ),
            ),
          ),

          // profile page button
          actions: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.029),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    profileDialog(context);
                  });
                },
                child: Icon(
                  Icons.account_circle,
                  color: const Color.fromARGB(255, 107, 154, 111),
                  size: screenWidth * 0.08,
                ),
              ),
            ),
          ],

          // search button
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                Navigator.of(context).pushNamed("/searchp");
              });
            },
            child: Icon(
              Icons.search,
              color: const Color.fromARGB(255, 107, 154, 111),
              size: screenWidth * 0.08,
            ),
          ),
        ),

        // body
        body: Center(
            child:
                // HOME PAGE UI
                currentIndex == 0
                    ? Container(
                        child: Column(
                          children: [
                            // Alquran Kareem content button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed("/alqurankareemp");
                                  });
                                },
                                child: _buildContentButton(
                                  screenWidth,
                                  screenHeight,
                                  "Al-Quran Kareem",
                                  "assets/alqurankareem.jpg",
                                ),
                              ),
                            ),

                            // Daily Invocations content button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed("/dailyinvocationsp");
                                  });
                                },
                                child: _buildContentButton(
                                  screenWidth,
                                  screenHeight,
                                  "Zikir Harian",
                                  "assets/dailyInvocations.jpg",
                                ),
                              ),
                            ),

                            // Friday Supplication content button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed("/fridaysupplicationsp");
                                  });
                                },
                                child: _buildContentButton(
                                  screenWidth,
                                  screenHeight,
                                  "Amalan Jumaat",
                                  "assets/fridaySupplications.jpg",
                                ),
                              ),
                            ),

                            // Islamic Events content button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed("/islamiceventsp");
                                  });
                                },
                                child: _buildContentButton(
                                  screenWidth,
                                  screenHeight,
                                  "Peristiwa Islam",
                                  "assets/islamicEvents.jpg",
                                ),
                              ),
                            ),

                            // Ziyarah content button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed("/ziyarahp");
                                  });
                                },
                                child: _buildContentButton(
                                  screenWidth,
                                  screenHeight,
                                  "Ziyarah (Lawatan)",
                                  "assets/ziyarah.jpg",
                                ),
                              ),
                            ),

                            // Mini content buttons
                            Row(
                              children: [
                                // Protection prayers content button
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.036,
                                      right: screenWidth * 0.025),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context)
                                            .pushNamed("/protectionprayersp");
                                      });
                                    },
                                    child: _buildContentButton(
                                      screenWidth,
                                      screenHeight,
                                      "Doa Pelindung Diri",
                                      "assets/protectionPrayers.jpg",
                                      widthFactor: 0.45,
                                      textSize: 0.04,
                                    ),
                                  ),
                                ),

                                // Biographies and references content button
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.036),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context).pushNamed(
                                            "/biographiesnreferencep");
                                      });
                                    },
                                    child: _buildContentButton(
                                      screenWidth,
                                      screenHeight,
                                      "Biografi dan Rujukan",
                                      "assets/biographiesnreference.jpg",
                                      widthFactor: 0.45,
                                      textSize: 0.04,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    :
                    // go to public bookmark page
                    currentIndex == 1
                        ? IlmPage()
                        :
                        // go to create post page
                        currentIndex == 2
                            ? CreatePostPage()
                            :
                            // go to Ilm Page
                            currentIndex == 3
                                ? BPublicPage()
                                :
                                // stays at home page
                                HomePage()),

        // navigation bar
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.05,
            horizontal: screenWidth * 0.04,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 64, 97, 66),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, -3),
                  ),
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 8.0),
              child: GNav(
                selectedIndex:
                    currentIndex, // will read the current index and will react within the UI
                gap: screenWidth * 0.01,
                onTabChange: (int index) {
                  if (index == 4) {
                    settingsDialog(context);
                  } else if (index != currentIndex) {
                    setState(() {
                      currentIndex = index;
                    });
                  }
                },
                backgroundColor: Colors.transparent,
                color:
                    Colors.white.withOpacity(0.7), // Inactive icon/text color
                activeColor: Colors.white, // Active icon/text color
                tabBackgroundColor: Colors.white.withOpacity(0.2),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.014,
                ),

                tabs: const [
                  GButton(
                    icon: Icons.home_rounded,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.newspaper,
                    text: "Ilm",
                  ),
                  GButton(
                    icon: Icons.add_circle_outline_rounded,
                    text: "Post",
                  ),
                  GButton(
                    icon: Icons.menu_book_rounded,
                    text: "Bookmark",
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: "Settings",
                  ),
                ],
              ),
            ),
          ),
        ),
        extendBody: true,
      ),
    );
  }

  Widget _buildContentButton(
      double screenWidth, double screenHeight, String title, String imagePath,
      {double widthFactor = 0.93, double textSize = 0.048}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.black,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: screenWidth * widthFactor,
      height: screenHeight * 0.1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            // Image with adjusted brightness overlay
            Image.asset(
              imagePath,
              fit: BoxFit.fitWidth,
              width: screenWidth * widthFactor,
              height: screenHeight * 0.1,
            ),
            Container(
              // Overlay with adjustable brightness level
              color: Colors.black
                  .withOpacity(0.55), // Change opacity for brightness
            ),
            // Title with blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.5,
                sigmaY: 1.5,
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * textSize * 0.9,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
