// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unused_import, avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/ilmpage.dart';
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
  final double contentWidth;
  final double contentHeight;
  final double strokeWidth;
  final double borderRadius;
  final double contentfontSize;

  //variable for mini content buttons
  final double miniContentWidth;
  final double miniContentHeight;

  _HomePageState({
    this.currentIndex = 0,
    this.contentWidth = 400,
    this.contentHeight = 100,
    this.strokeWidth = 4,
    this.borderRadius = 10,
    this.contentfontSize = 20,
    this.miniContentWidth = 196,
    this.miniContentHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // attribute for wallpaper
      decoration: BoxDecoration(
        image: DecorationImage(
          // Change wallpaper based on the setting (lightmode/darkmode)
          // need to test with xcode

          image: Provider.of<ThemeProvider>(context).themeData == lightmode
              ? AssetImage("assets/Lightwallpaper.png")
              : Provider.of<ThemeProvider>(context).themeData == darkmode
                  ? AssetImage("assets/Darkwallpaper.png")
                  : AssetImage("assets/Lightwallpaper.png"),
          fit: BoxFit.fill,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          // majmu' logo
          toolbarHeight: 100,
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
                    Navigator.of(context).pushNamed("/profilep");
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

                // HOME PAGE
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
                                    Navigator.of(context).pushNamed("/alqurankareemp");
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
                                  width: contentWidth,
                                  height: contentHeight,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Al-quran Kareem",
                                        style: TextStyle(
                                          fontSize: contentfontSize,
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
                                          fontSize: contentfontSize,
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
                                    Navigator.of(context).pushNamed("");
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
                                  width: contentWidth,
                                  height: contentHeight,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Daily Invocations",
                                        style: TextStyle(
                                          fontSize: contentfontSize,
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
                                          fontSize: contentfontSize,
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
                                    Navigator.of(context).pushNamed("");
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
                                  width: contentWidth,
                                  height: contentHeight,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Friday Supplication",
                                        style: TextStyle(
                                          fontSize: contentfontSize,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = strokeWidth
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      // White fill text
                                      Text(
                                        "Friday Supplication",
                                        style: TextStyle(
                                          fontSize: contentfontSize,
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
                                    Navigator.of(context).pushNamed("");
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
                                  width: contentWidth,
                                  height: contentHeight,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Islamic Events",
                                        style: TextStyle(
                                          fontSize: contentfontSize,
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
                                          fontSize: contentfontSize,
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
                                    Navigator.of(context).pushNamed("");
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/ziyarah.jpg"),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                  ),
                                  width: contentWidth,
                                  height: contentHeight,
                                  child: Center(

                                      //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                      child: Stack(
                                    children: <Widget>[
                                      // Black stroke text
                                      Text(
                                        "Ziyarah (visits)",
                                        style: TextStyle(
                                          fontSize: contentfontSize,
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
                                          fontSize: contentfontSize,
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
                                  padding: const EdgeInsets.only(left: 23.0, right: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context).pushNamed("");
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
                                      width: miniContentWidth,
                                      height: miniContentHeight,
                                      child: Center(

                                          //we use stack to make two text on top of each other to create an illusion of inside and outside stroke (outline text)
                                          child: Stack(
                                        children: <Widget>[
                                          // Black stroke text
                                          Text(
                                            "Protection Prayers",
                                            style: TextStyle(
                                              fontSize: contentfontSize,
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
                                              fontSize: contentfontSize,
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
                                  padding: const EdgeInsets.only(right: 23.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.of(context).pushNamed("");
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
                                      width: miniContentWidth,
                                      height: miniContentHeight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(23.0),
                                        child: Stack(
                                          
                                          children: <Widget>[
                                            // Black stroke text
                                            Text(
                                              "Biographies and References",
                                              style: TextStyle(
                                                fontSize: contentfontSize,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = strokeWidth
                                                  ..color = Colors.black,
                                              ),
                                              
                                            ),
                                            // White fill text
                                            Text(
                                              "Biographies and References",
                                              style: TextStyle(
                                                fontSize: contentfontSize,
                                                color: Colors
                                                    .white, // This sets the inside color of the text
                                              ),
                                            ),
                                          ],
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

                                // go to setting page
                                currentIndex == 4
                                    ? SettingPage()
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
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
        extendBody: true,
      ),
    );
  }
}
