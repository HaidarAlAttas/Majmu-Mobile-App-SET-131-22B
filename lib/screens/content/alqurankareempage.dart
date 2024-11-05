// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, dead_code, unused_element

import 'package:flutter/material.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/content/content%20components/content_button.dart';
import 'package:majmu/components/homepage%20components/homepage_content.dart';
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
              // alquran arranged by surah
              ContentButton(
                name: "Alquran arranged by Surah",
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomepageContent(
                            folder: "/alqurankareem/surah",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              // alquran arranged by juz
              ContentButton(
                name: "Quran arranged by Juz",
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomepageContent(
                            folder: "/alqurankareem/juz",
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
