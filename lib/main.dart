// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:majmu/content/alqurankareempage.dart';
import 'package:majmu/content/biographiesnreferencepage.dart';
import 'package:majmu/content/dailyinvocationspage.dart';
import 'package:majmu/content/fridaysupplicationspage.dart';
import 'package:majmu/content/islamiceventspage.dart';
import 'package:majmu/content/protectionprayerspage.dart';
import 'package:majmu/content/ziyarahpage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/profilepage.dart';
import 'package:majmu/screens/searchpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {

        // main routes
        "/home": (context) => const HomePage(),
        "/bpublic": (context) => const BPublicPage(),
        "/createp": (context) => const CreatePostPage(),
        "/ilmp": (context) => const IlmPage(),
        "/settingp": (context) => const SettingPage(),
        "/profilep": (context) => const ProfilePage(),
        "/searchp": (context) => const SearchPage(),


        // content routes
        "/alqurankareemp": (context) => const AlquranKareemPage(),
        "/dailyinvocationsp": (context) => const DailyInvocationsPage(),
        "/fridaysupplicationsp": (context) => const FridaySupplicationsPage(),
        "/islamiceventsp": (context) => const IslamicEventsPage(),
        "/ziyarahp": (context) => const ZiyarahPage(),
        "/protectionprayersp": (context) => const ProtectionPrayersPage(),
        "/biographiesnreferencep": (context) => const BiographiesnReferencePage(),

      },

      
      debugShowCheckedModeBanner: false,
    );
  }
}
