// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:majmu/firebase_options.dart';
import 'package:majmu/screens/auth/forgotpassword.dart';
import 'package:majmu/screens/auth/registerpage.dart';
import 'package:majmu/screens/auth/loginpage.dart';
import 'package:majmu/screens/content/alqurankareempage.dart';
import 'package:majmu/screens/content/biografi_dan_rujukanpage.dart';
import 'package:majmu/screens/content/zikir_harianpage.dart';
import 'package:majmu/screens/content/amalan_jumaatpage.dart';
import 'package:majmu/screens/content/peristiwa_islampage.dart';
import 'package:majmu/screens/content/doa_pelindung_diripage.dart';
import 'package:majmu/screens/content/lawatan_ziyarahpage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/docscan.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/profile/editprofilepage.dart';
import 'package:majmu/screens/profile/logoutpage.dart';
import 'package:majmu/screens/profile/yourprofile/yourpostspage.dart';
import 'package:majmu/screens/searchpage.dart';
import 'package:majmu/screens/settings/accountpage.dart';
import 'package:majmu/screens/settings/customerservicepage.dart';
import 'package:majmu/screens/settings/storagendatapage.dart';
import 'package:majmu/screens/settings/themepage.dart';
import 'package:majmu/screens/splashscreen.dart';
import 'package:majmu/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        // authentication routes
        "/staylogged": (context) => StayLogged(),
        "/registerp": (context) => const RegisterPage(),
        "/loginp": (context) => const LoginPage(),
        "/forgotpasswordp": (context) => ForgotPasswordPage(),

        // main app routes
        "/splash": (context) => const SplashScreen(),
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

      // remove demo sign
      debugShowCheckedModeBanner: false,
    );
  }
}
