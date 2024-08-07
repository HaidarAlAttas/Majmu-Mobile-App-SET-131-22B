// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unused_import

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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // nak bagi wallpaper masuk belakang appbar skali (extend body and makesure pakai color transparent)
      extendBodyBehindAppBar: true,
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

              // home page
              currentIndex == 0
                  ? Container(
                      // attribute for wallpaper
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // Change wallpaper based on the setting (lightmode/darkmode)
                          // need to test with xcode

                          image: Provider.of<ThemeProvider>(context)
                                      .themeData ==
                                  lightmode
                              ? AssetImage("assets/Lightwallpaper.png")
                              : Provider.of<ThemeProvider>(context).themeData ==
                                      darkmode
                                  ? AssetImage("assets/Darkwallpaper.png")
                                  : AssetImage("assets/Lightwallpaper.png"),
                          fit: BoxFit.fill,
                        ),
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
    );
  }
}
