// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String name;
  final String description;

  const PDFViewerPage({
    Key? key,
    required this.pdfUrl,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PdfController? _pdfController;

  @override
  void initState() {
    super.initState();
    _loadAndDisplayPDF();
  }

  Future<void> _loadAndDisplayPDF() async {
    final pdfFile = await _downloadPDF(widget.pdfUrl);
    _pdfController = PdfController(
      document: PdfDocument.openFile(pdfFile.path),
    );

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Swipe to the left',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.grey[800],
      ),
    );
  }

  Future<File> _downloadPDF(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load PDF');
      }
      final bytes = response.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloaded.pdf');
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.transparent,
        actions: [
          // Info button to show full description
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      widget.name,
                    ),
                    content: Text(
                      "description:\n\n" + widget.description,
                    ), // Replace "data" with your actual description variable
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.017),
              child: Icon(
                Icons.info_outline_rounded,
              ),
            ),
          ),
        ],
      ),
      body: _pdfController == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : PdfView(controller: _pdfController!),
    );
  }
}
