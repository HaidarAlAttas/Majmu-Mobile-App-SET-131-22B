// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unused_import, avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';
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
      // attribute for wallpaper
      decoration: BoxDecoration(
        image: DecorationImage(
          // Change wallpaper based on the setting (lightmode/darkmode)
          image: AssetImage("assets/Lightwallpaper.png"),
          fit: BoxFit.fill,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          // majmu' logo
          toolbarHeight: screenHeight * 0.10,
          backgroundColor: Colors.transparent,
          title: Center(
            // when click the majmu' logo, it will go back to the home page
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: Image(
                image: AssetImage("assets/Majmu'.png"),
                height: 70,
                width: 70,
              ),
            ),
          ),

          // profile page button
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    profileDialog(context);
                  });
                },
                child: Icon(
                  Icons.account_circle,
                  color: const Color.fromARGB(255, 26, 151, 33),
                  size: 30,
                ),
              ),
            ),
          ],

          // search button
          leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.of(context).pushNamed("/searchp");
              });
            },
            child: Icon(
              Icons.search,
              color: const Color.fromARGB(255, 26, 151, 33),
              size: 30,
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
                                  "Al-quran Kareem",
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
                                  "Daily Invocations",
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
                                  "Friday Supplications",
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
                                  "Islamic Events",
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
                                  "Ziyarah (Visits)",
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
                                      "Protection Prayers",
                                      "assets/protectionPrayers.jpg",
                                      widthFactor: 0.45,
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
                                      "Biographies and References",
                                      "assets/biographiesnreference.jpg",
                                      widthFactor: 0.45,
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
                        ? BPublicPage()
                        :
                        // go to create post page
                        currentIndex == 2
                            ? CreatePostPage()
                            :
                            // go to Ilm Page
                            currentIndex == 3
                                ? IlmPage()
                                :
                                // stays at home page
                                HomePage()),

        // navigation bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.transparent,

          // to change pages
          onTap: (int index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },

          iconSize: 47,

          // to remove shadow under bottom navigation bar
          elevation: 0,

          // to make sure bottom navigation bar muat 5 item
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.home_rounded,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.menu_book_rounded,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.add_circle_rounded,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.newspaper,
                color: Colors.black,
              ),
            ),
            // Setting buttons logic
            BottomNavigationBarItem(
              label: "",
              icon: GestureDetector(
                // if clicked
                onTap: () {
                  // go to the setting page
                  settingsDialog(context);
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        extendBody: true,
      ),
    );
  }

  Widget _buildContentButton(
      double screenWidth, double screenHeight, String title, String imagePath,
      {double widthFactor = 0.93}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(imagePath),
        ),
        borderRadius: BorderRadius.circular(borderRadius),
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5), // Blur effect
          child: Center(
            child: Stack(
              children: <Widget>[
                // Black stroke text
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.048,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = strokeWidth
                      ..color = Colors.black,
                  ),
                ),
                // White fill text
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.048,
                    color:
                        Colors.white, // This sets the inside color of the text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
