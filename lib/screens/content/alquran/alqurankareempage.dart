// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, dead_code, unused_element

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

class AlquranKareemPage extends StatefulWidget {
  const AlquranKareemPage({super.key});

  @override
  State<AlquranKareemPage> createState() => _AlquranKareemPageState();
}

class _AlquranKareemPageState extends State<AlquranKareemPage> {
  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Method to create the Surah content button
    Widget AlquranSurahContent() {
      return GestureDetector(
        // Detect input
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, "/alquransurahp");
          });
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // Changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Surah content name
              Expanded(
                child: Text(
                  "Al-Quran arranged by Surah",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              // Icon to go to the content file (>)
              Icon(
                Icons.navigate_next_rounded,
                color: Colors.black,
                size: screenWidth * 0.089,
              ),
            ],
          ),
        ),
      );
    }

    // Method to create the Juz content button
    Widget AlquranJuzContent() {
      return GestureDetector(
        // Detect input
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, "/alquranjuzp");
          });
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // Changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Juz content name
              Expanded(
                child: Text(
                  "Al-Quran arranged by Juz",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              // Icon to go to the content file (>)
              Icon(
                Icons.navigate_next_rounded,
                color: Colors.black,
                size: screenWidth * 0.089,
              ),
            ],
          ),
        ),
      );
    }

    // WALLPAPER
    // Background wallpaper color
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 241, 222),
      ),
      // BODY
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // Back button
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
        // Contents
        body: SingleChildScrollView(
          child: Column(
            children: [
              AlquranSurahContent(),
              AlquranJuzContent(),
            ],
          ),
        ),
      ),
    );
  }
}
