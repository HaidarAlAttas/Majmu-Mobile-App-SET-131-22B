// ignore_for_file: unused_import, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/components/homepage%20components/homepage_content.dart';
import 'package:majmu/screens/content/content%20components/content_button.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';

class DailyInvocationsPage extends StatefulWidget {
  const DailyInvocationsPage({super.key});

  @override
  State<DailyInvocationsPage> createState() => _DailyInvocationsPageState();
}

class _DailyInvocationsPageState extends State<DailyInvocationsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Background wallpaper color
      backgroundColor: Color.fromARGB(255, 245, 241, 222),
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
            // need to configure because in sunnah harian there's only one page
            // Sunnah Harian
            ContentButton(
              name: "Sunnah Harian",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder: "/dailyinvocations/001_Sunnah Harian/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Selepas Solat Fardhu
            ContentButton(
              name: "Selepas Solat Fardhu",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder: "/dailyinvocations/002_Selepas Solat Fardhu/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Selepas Solat Subuh
            ContentButton(
              name: "Selepas Solat Subuh",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder: "/dailyinvocations/003_Selepas Solat Subuh/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Selepas Solat Zohor
            ContentButton(
              name: "Selepas Solat Zohor",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder: "/dailyinvocations/004_Selepas Solat Zohor/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Selepas Solat Asar
            ContentButton(
              name: "Selepas Solat Asar",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder: "/dailyinvocations/005_Selepas Solat Asar/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Sebelum Atau Selepas Solat Maghrib
            ContentButton(
              name: "Sebelum Atau Selepas Solat Maghrib",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder:
                              "/dailyinvocations/006_Sebelum Atau Selepas Solat Maghrib/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Selepas Solat Ishak
            ContentButton(
              name: "Selepas Solat Ishak",
              onTap: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomepageContent(
                          folder: "/dailyinvocations/007_Selepas Solat Ishak/",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
