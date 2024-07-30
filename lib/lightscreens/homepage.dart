// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // nak bagi wallpaper masuk belakang app bar skali (extend body ngan pakai color transparent)
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // majmu' logo
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Image(
            image: AssetImage("assets/Majmu'.png"),
            height: 70,
            width: 70,
          ),
        ),

        // profile pageh button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.account_circle,
              color: const Color.fromARGB(255, 26, 151, 33),
              size: 30,
            ),
          ),
        ],

        // search button
        leading: Icon(
          Icons.search,
          color: const Color.fromARGB(255, 26, 151, 33),
          size: 30,
        ),
      ),
      body: Container(
        // attribute for wallpaper
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Lightwallpaper.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),

      // navigationbar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        iconSize: 40,
        
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
