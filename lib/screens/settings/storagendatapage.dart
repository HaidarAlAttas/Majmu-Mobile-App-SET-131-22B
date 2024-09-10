// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

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

class StorageAndDataPage extends StatefulWidget {
  const StorageAndDataPage({super.key});

  @override
  State<StorageAndDataPage> createState() => _StorageAndDataPageState();
}

class _StorageAndDataPageState extends State<StorageAndDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [],),
    );
  }
}