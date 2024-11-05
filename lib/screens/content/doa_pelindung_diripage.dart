// ignore_for_file: unused_import, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/components/homepage%20components/homepage_content.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ProtectionPrayersPage extends StatefulWidget {
  const ProtectionPrayersPage({super.key});

  @override
  State<ProtectionPrayersPage> createState() => _ProtectionPrayersPageState();
}

class _ProtectionPrayersPageState extends State<ProtectionPrayersPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return HomepageContent(
      folder: "/protectionprayers/",
    );
  }
}
