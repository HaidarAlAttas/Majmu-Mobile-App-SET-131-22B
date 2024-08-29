// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_unnecessary_containers

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

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 700,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 36, 36, 36),
          ),

          // setting items
          // Partitioning:
          // Settings title
          // Majmu', account
          // Storage and data, theme
          // Customer service

          child: Column(
            children: [
              // setting
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Majmu' and account container
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 10, left: 8, right: 8),
                child: Container(
                  height: 120,
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 85, 84, 84),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  // majmu' and account button
                  child: Column(
                    children: [
                      // Majmu' button
                      GestureDetector(
                        // show Majmu' details
                        onTap: () {
                          setState(() {});
                        },

                        // UI for the whole Majmu' button
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Majmu' Image
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image(
                                      image: AssetImage("assets/Majmu'.png"),
                                      height: 45,
                                    ),
                                  ),

                                  // text for Majmu' button
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Majmu' text
                                      Text(
                                        "Majmu'",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      // sunnah origin text
                                      Text(
                                        "Sunnah Origin",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // icon for next
                              Icon(
                                Icons.navigate_next_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // account button
                      GestureDetector(
                        // show Account details
                        onTap: () {
                          setState(() {});
                        },

                        // UI for whole Account button
                        child: Container(
                          width: 330,
                          decoration: BoxDecoration(
                            // to create a line on top of account button
                            border: Border(
                              top: BorderSide(width: 2, color: Colors.grey),
                            ),
                          ),

                          // Account button icon and text
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 8, top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    // Account button icon
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 22.0),
                                      child: Icon(
                                        Icons.manage_accounts_rounded,
                                        size: 30,
                                        color: Colors.green,
                                      ),
                                    ),

                                    // Account button text
                                    Text(
                                      "Account",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // icon for next
                              Icon(
                                Icons.navigate_next_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // storage and data, theme, customer service container

              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 85, 84, 84),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    // Storage and data button
                      GestureDetector(
                        // show Storage and data details
                        onTap: () {
                          setState(() {});
                        },

                        // UI for whole Storage and data button
                        child: Container(
                          width: 330,
                          decoration: BoxDecoration(
                            // to create a line on top of account button
                            border: Border(
                              bottom: BorderSide(width: 2, color: Colors.grey),
                            ),
                          ),

                          // storage and data button icon and text
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 8, top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    // storage and data icon
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 22.0),
                                      child: Icon(
                                        Icons.sd_storage_rounded,
                                        size: 30,
                                        color: Colors.orange,
                                      ),
                                    ),

                                    // storage and data text
                                    Text(
                                      "Account",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // icon for next
                              Icon(
                                Icons.navigate_next_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
