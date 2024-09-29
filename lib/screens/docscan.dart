// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cunning_document_scanner/cunning_document_scanner.dart';

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

  Future<void> initPlatformState() async {
    // Initialize the document scanner if needed
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Scan Document now'),
                ),
                ElevatedButton(
                  onPressed: saveAsPDF,
                  child: const Text('Save as PDF'),
                ),
                _pictures.isEmpty
                    ? const Text('No pictures scanned yet.')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _pictures.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(_pictures[index]),
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressed() async {
    try {
      List<String> scannedImages =
          await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;

      setState(() {
        _pictures = scannedImages;
      });
    } catch (exception) {
      print('Error: $exception');
    }
  }

  Future<void> saveAsPDF() async {
    final pdf = pw.Document();
    final directory = await getApplicationDocumentsDirectory();
    final pdfFilePath =
        '${directory.path}/scanned_document_${DateTime.now().millisecondsSinceEpoch}.pdf';

    try {
      for (String imagePath in _pictures) {
        final imageBytes = await File(imagePath).readAsBytes();
        final pdfImage = pw.MemoryImage(imageBytes);

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) => pw.Image(pdfImage),
          ),
        );
      }

      final outputFile = File(pdfFilePath);
      await outputFile.writeAsBytes(await pdf.save());

      print('PDF saved at $pdfFilePath');
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }
}
