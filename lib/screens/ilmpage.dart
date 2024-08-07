// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

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

class IlmPage extends StatefulWidget {
  const IlmPage({super.key});

  @override
  State<IlmPage> createState() => _IlmPageState();
}

class _IlmPageState extends State<IlmPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // nak bagi wallpaper masuk belakang app bar skali (extend body ngan pakai color transparent)
      extendBodyBehindAppBar: true,

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
                              ? SingleChildScrollView(
                                  child: Scaffold(
                                    appBar: AppBar(
                                      title: Text(""),
                                    ),
                                  ),
                                )
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
          setState(() {
            currentIndex = index;
          });
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
