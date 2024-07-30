import 'package:flutter/material.dart';
import 'package:majmu/lightscreens/bpublicpage.dart';
import 'package:majmu/lightscreens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        "/home": (context) => const HomePage(),
        "/bpublic": (context) => const BPublicPage(),
      },
      debugShowCheckedModeBanner: false,
    );
      
  }
}
