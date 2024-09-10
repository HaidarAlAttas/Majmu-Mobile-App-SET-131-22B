// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:majmu/screens/content/alqurankareempage.dart';
import 'package:majmu/screens/content/biographiesnreferencepage.dart';
import 'package:majmu/screens/content/dailyinvocationspage.dart';
import 'package:majmu/screens/content/fridaysupplicationspage.dart';
import 'package:majmu/screens/content/islamiceventspage.dart';
import 'package:majmu/screens/content/protectionprayerspage.dart';
import 'package:majmu/screens/content/ziyarahpage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/camerascan.dart';
import 'package:majmu/screens/docscan.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/profile/editprofilepage.dart';
import 'package:majmu/screens/profile/logoutpage.dart';
import 'package:majmu/screens/profile/yourpostspage.dart';
import 'package:majmu/screens/profilepage.dart';
import 'package:majmu/screens/searchpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/screens/settings/accountpage.dart';
import 'package:majmu/screens/settings/customerservicepage.dart';
import 'package:majmu/screens/settings/storagendatapage.dart';
import 'package:majmu/screens/settings/themepage.dart';
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
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        // main routes
        "/home": (context) => const HomePage(),
        "/bpublic": (context) => const BPublicPage(),
        "/createp": (context) => const CreatePostPage(),
        "/ilmp": (context) => const IlmPage(),
        "/searchp": (context) => const SearchPage(),

        // content routes
        "/alqurankareemp": (context) => const AlquranKareemPage(),
        "/dailyinvocationsp": (context) => const DailyInvocationsPage(),
        "/fridaysupplicationsp": (context) => const FridaySupplicationsPage(),
        "/islamiceventsp": (context) => const IslamicEventsPage(),
        "/ziyarahp": (context) => const ZiyarahPage(),
        "/protectionprayersp": (context) => const ProtectionPrayersPage(),
        "/biographiesnreferencep": (context) =>
            const BiographiesnReferencePage(),

        // camera routes
        "/docscan": (context) => const DocScan(),
        "/camerascan": (context) => const CameraScan(),

        // settings route
        "/storagep": (context) => const StorageAndDataPage(),
        "/customerservp": (context) => const CustomerServicePage(),
        "/accountp": (context) => const AccountPage(),
        "/themep": (context) => const ThemePage(),

        // profile page route

        "/editprofilep": (context) => const EditProfilePage(),
        "/logoutp": (context) => const LogoutPage(),
        "/yourpostsp": (context) => const YourPostsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
