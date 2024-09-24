// ignore_for_file: unused_import, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:majmu/firebase_options.dart';
import 'package:majmu/screens/auth/registerpage.dart';
import 'package:majmu/screens/auth/loginpage.dart';
import 'package:majmu/screens/content/alquran/alqurankareempage.dart';
import 'package:majmu/screens/content/alquran/juz.dart';
import 'package:majmu/screens/content/alquran/surah.dart';
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
import 'package:majmu/screens/splashscreen.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
        "/registerp": (context) => const RegisterPage(),
        "/loginp": (context) => const LoginPage(),

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

        // alquran kareem route
        "/alquransurahp": (context) => const SurahPage(),
        "/alquranjuzp": (context) => const JuzPage(),
      },

      // remove demo sign
      debugShowCheckedModeBanner: false,
    );
  }
}
