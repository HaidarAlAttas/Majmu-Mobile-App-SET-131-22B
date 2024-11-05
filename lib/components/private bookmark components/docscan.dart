// ignore_for_file: unused_import, prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:intl/intl.dart';

class DocScanButton extends StatefulWidget {
  const DocScanButton({super.key});

  @override
  State<DocScanButton> createState() => _DocScanButtonState();
}

class _DocScanButtonState extends State<DocScanButton> {
  String? fileName;
  String? description;
  List<String> _scannedImages = [];
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // add new bookmarks button
    return SizedBox(
      width: screenWidth * 0.6,
      child: ElevatedButton(
        // inside the ElevatedButton onPressed to show the dialog
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Add New Bookmarks'),
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TextField for file name
                    TextField(
                      onChanged: (value) => fileName = value,
                      decoration: InputDecoration(
                        labelText: 'File Name',
                        labelStyle:
                            TextStyle(color: Colors.grey), // Label color
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                          borderSide: BorderSide(
                              color: Color.fromARGB(
                                  255, 98, 147, 101)), // Border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 98, 147, 101),
                              width: 2), // Thicker border when focused
                        ),
                        filled: true,
                        fillColor: Colors.white, // Background color
                        contentPadding:
                            EdgeInsets.all(12), // Padding inside the TextField
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.012,
                    ),

                    // Multi-line TextField for file description
                    TextField(
                      onChanged: (value) => description = value,
                      decoration: InputDecoration(
                        labelText: 'Descriptions',
                        labelStyle:
                            TextStyle(color: Colors.grey), // Label color
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                          borderSide: BorderSide(
                              color: Color.fromARGB(
                                  255, 98, 147, 101)), // Border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 98, 147, 101),
                              width: 2), // Thicker border when focused
                        ),
                        filled: true,
                        fillColor: Colors.white, // Background color
                        contentPadding:
                            EdgeInsets.all(12), // Padding inside the TextField
                      ),
                      maxLines: 3, // Set to 3 or more for multi-line
                      keyboardType: TextInputType.multiline,
                    ),

                    SizedBox(
                      height: screenHeight * 0.012,
                    ),

                    // Row for buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cancel button
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                        // Scan File button
                        ElevatedButton(
                          onPressed: () {
                            // Call the doc scanner method
                            scanAndSavePDF();
                            // Close the Dialog after the process is finished
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Scan File',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 98, 147, 101), // Button color
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                            ),
                            elevation: 5, // Shadow effect
                          ),
                        ),

                        // Show the progress indicator only when uploading
                        if (_isUploading)
                          Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        child: Text(
          'Add New Bookmarks',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 98, 147, 101),
          padding: EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 12.0), // Adjusted padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
          elevation: 5, // Elevation for shadow
        ),
      ),
    );
  }

  Future<void> scanAndSavePDF() async {
    try {
      setState(() {
        _isUploading = true;
      });

      final List<String>? scannedImages =
          await CunningDocumentScanner.getPictures();

      if (scannedImages != null &&
          scannedImages.isNotEmpty &&
          fileName != null &&
          description != null) {
        final pdf = pw.Document();
        final directory = await getApplicationDocumentsDirectory();
        final pdfFilePath = '${directory.path}/$fileName.pdf';

        for (String imagePath in scannedImages) {
          final image = pw.MemoryImage(File(imagePath).readAsBytesSync());
          pdf.addPage(pw.Page(build: (pw.Context context) => pw.Image(image)));
        }

        final pdfFile = File(pdfFilePath);
        await pdfFile.writeAsBytes(await pdf.save());

        // Upload PDF to Firebase Storage
        final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        final String uniquePdfId =
            DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('privateBookmark/$currentUserId/$uniquePdfId.pdf');
        await storageRef.putFile(pdfFile);
        final downloadUrl = await storageRef.getDownloadURL();

        // Upload Preview Image
        final previewImagePath = scannedImages.first;
        final previewImageRef = FirebaseStorage.instance
            .ref()
            .child('privateBookmark/$currentUserId/preview_$uniquePdfId.jpg');
        await previewImageRef.putFile(File(previewImagePath));
        final previewImageUrl = await previewImageRef.getDownloadURL();

        // format the date so that can be easily readable
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

        // Save file details in Firestore
        await FirebaseFirestore.instance
            .collection('user-cred')
            .doc(currentUserId)
            .collection('privateBookmarks')
            .doc(uniquePdfId)
            .set({
          'name': fileName,
          'description': description,
          'previewImageUrl': previewImageUrl,
          'fileUrl': downloadUrl,
          'dateCreated': formattedDate,
        });

        setState(() {
          _isUploading = false;
        });

        // Show a Snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('File uploaded successfully!'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );

        print('PDF saved and uploaded successfully');
      } else {
        print('No scanned images or missing fields.');
      }
    } catch (e) {
      Navigator.of(context).pop();
      setState(() {
        _isUploading = false;
      });
      print('Error during scanning or saving: $e');
    }
  }
}
