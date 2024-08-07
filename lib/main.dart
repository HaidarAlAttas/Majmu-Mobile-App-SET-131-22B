import 'package:flutter/material.dart';
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
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
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
        "/home": (context) => const HomePage(),
        "/bpublic": (context) => const BPublicPage(),
        "/createp": (context) => const CreatePostPage(),
        "/ilm": (context) => const IlmPage(),
        "/setting": (context) => const SettingPage(),
        "/profilep": (context) => const ProfilePage(),
        "/searchp": (context) => const SearchPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
