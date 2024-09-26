// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ContentViewer extends StatelessWidget {
  final String path;
  final String name;

  ContentViewer({required this.path, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back button
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),

        title: Text(name),
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}
