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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variable for changing pages on bottomnavbar
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
          // need to test with xcode

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
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/alqurankareem.jpg"),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                  ),
                                  width: screenWidth * 0.93,
                                  height: screenHeight * 0.1,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Al-quran Kareem",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = strokeWidth
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      // White fill text
                                      Text(
                                        "Al-quran Kareem",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Colors
                                              .white, // This sets the inside color of the text
                                        ),
                                      ),
                                    ],
                                  )),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/dailyInvocations.jpg"),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                  ),
                                  width: screenWidth * 0.93,
                                  height: screenHeight * 0.1,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Daily Invocations",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = strokeWidth
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      // White fill text
                                      Text(
                                        "Daily Invocations",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Colors
                                              .white, // This sets the inside color of the text
                                        ),
                                      ),
                                    ],
                                  )),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/fridaySupplications.jpg"),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                  ),
                                  width: screenWidth * 0.93,
                                  height: screenHeight * 0.1,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Friday Supplications",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = strokeWidth
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      // White fill text
                                      Text(
                                        "Friday Supplications",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Colors
                                              .white, // This sets the inside color of the text
                                        ),
                                      ),
                                    ],
                                  )),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/islamicEvents.jpg"),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                  ),
                                  width: screenWidth * 0.93,
                                  height: screenHeight * 0.1,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Islamic Events",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = strokeWidth
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      // White fill text
                                      Text(
                                        "Islamic Events",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Colors
                                              .white, // This sets the inside color of the text
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ),

                            // Ziyarah (visits) content button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed("/ziyarahp");
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage("assets/ziyarah.jpg"),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                  ),
                                  width: screenWidth * 0.93,
                                  height: screenHeight * 0.1,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Ziyarah (visits)",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = strokeWidth
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      // White fill text
                                      Text(
                                        "Ziyarah (visits)",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Colors
                                              .white, // This sets the inside color of the text
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ),

                            // mini content buttons

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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: AssetImage(
                                              "assets/protectionPrayers.jpg"),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(borderRadius),
                                      ),
                                      width: screenWidth * 0.45,
                                      height: screenHeight * 0.1,
                                      child: Center(

                                          //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                          child: Stack(
                                        children: <Widget>[
                                          // Black stroke text
                                          Text(
                                            "Protection Prayers",
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
                                            "Protection Prayers",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.048,
                                              color: Colors
                                                  .white, // This sets the inside color of the text
                                            ),
                                          ),
                                        ],
                                      )),
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: AssetImage(
                                              "assets/biographiesnreference.jpg"),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(borderRadius),
                                      ),
                                      width: screenWidth * 0.45,
                                      height: screenHeight * 0.1,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.06),
                                          child: Stack(
                                            children: <Widget>[
                                              // Black stroke text
                                              Text(
                                                "Biographies and References",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.040,
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = strokeWidth
                                                    ..color = Colors.black,
                                                ),
                                              ),
                                              // White fill text
                                              Text(
                                                "Biographies and References",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.040,
                                                  color: Colors
                                                      .white, // This sets the inside color of the text
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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

        // navigationbar
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
}
