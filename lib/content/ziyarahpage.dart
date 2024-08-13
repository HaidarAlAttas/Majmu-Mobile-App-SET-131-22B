// ignore_for_file: unused_import, prefer_const_constructors

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

class ZiyarahPage extends StatefulWidget {
  const ZiyarahPage({super.key});

  @override
  State<ZiyarahPage> createState() => _ZiyarahPageState();
}

class _ZiyarahPageState extends State<ZiyarahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [],),);
  }
}