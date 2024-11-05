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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: _pdfController == null
          ? Center(child: CircularProgressIndicator())
          : PdfView(controller: _pdfController!),
    );
  }
}
