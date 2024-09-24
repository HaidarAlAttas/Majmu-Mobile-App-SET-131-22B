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
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // create method to apply a blueprint for the contents
    Widget AlquranSurahContent() {
      return GestureDetector(
        // detect input
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, "/alquransurahp");
          });
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              right: screenWidth * 0.03,
              left: screenWidth * 0.03,
              bottom: screenHeight * 0.01),
          child: Container(
            padding: EdgeInsets.all(10),
            height: screenHeight * 0.073,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 255, 244, 179),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // demo content name
                Text(
                  "Al-Quran arranged by Surah",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // conditional statement for the text in the button color
                    color: Colors.black,
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

    // create method to apply a blueprint for the contents
    Widget AlquranJuzContent() {
      return GestureDetector(
        // detect input
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, "/alquranjuzp");
          });
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
              color: Color.fromARGB(255, 255, 244, 179),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // demo content name
                Text(
                  "Al-Quran arranged by Juz",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // conditional statement for the text in the button color
                    color: Colors.black,
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

    // WALLPAPER
    // background wallpaper color
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 241, 222),
      ),

      // BODY
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          // back button
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),

        // contents
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
