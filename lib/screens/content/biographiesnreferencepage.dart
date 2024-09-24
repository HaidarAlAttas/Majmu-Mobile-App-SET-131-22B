// ignore_for_file: unused_import

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

class BiographiesnReferencePage extends StatefulWidget {
  const BiographiesnReferencePage({super.key});

  @override
  State<BiographiesnReferencePage> createState() =>
      _BiographiesnReferencePageState();
}

class _BiographiesnReferencePageState extends State<BiographiesnReferencePage> {
  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
    );
  }
}
