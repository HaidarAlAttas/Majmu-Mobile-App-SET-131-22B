// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';


// masukkan document scanner package here
// continue 23/8 && 24/8

class DocScan extends StatefulWidget {
  const DocScan({super.key});

  @override
  State<DocScan> createState() => _DocScanState();
}

class _DocScanState extends State<DocScan> {
  List<String> _pictures = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scanning demo'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            
          ],
        )),
      ),
    );
  }

  void onPressed() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }
}

