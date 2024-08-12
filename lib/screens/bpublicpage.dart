// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

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

class BPublicPage extends StatefulWidget {
  const BPublicPage({super.key});

  @override
  State<BPublicPage> createState() => _BPublicPageState();
}

class _BPublicPageState extends State<BPublicPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // body
      body: Center(
        child: Container(
          
        ),

        // home page
      ),
    );
  }
}
