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
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

class DocScanButton extends StatefulWidget {
  const DocScanButton({super.key});

  @override
  State<DocScanButton> createState() => _DocScanButtonState();
}

class _DocScanButtonState extends State<DocScanButton> {
  String? fileName;
  String? description;
  List<String> _scannedImages = [];

  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Add new bookmarks button
    return FloatingActionButton(
      // show a popup
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,

            // title
            title: Text('Add New Bookmarks'),
            content: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.01,
                vertical: screenHeight * 0.01,
              ),

              // content inside dialog box
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextField for file name
                  Container(
                    width: screenWidth * 0.8,
                    child: TextField(
                      onChanged: (value) => fileName = value,
                      maxLength: 50,
                      decoration: InputDecoration(
                        labelText: 'File Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 98, 147, 101)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 98, 147, 101),
                              width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.012),

                  // Multi-line TextField for file description
                  Container(
                    width: screenWidth * 0.8,
                    child: TextField(
                      onChanged: (value) => description = value,
                      maxLength: 400,
                      decoration: InputDecoration(
                        labelText: 'Descriptions',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 98, 147, 101)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 98, 147, 101),
                              width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(12),
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.012),

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
                          requestCameraPermission().then((granted) {
                            if (granted) {
                              // If granted, proceed to scan

                              //

                              scanAndSavePDF();
                              // Close the Dialog after the process is finished
                              Navigator.of(context).pop();
                            } else {
                              // Handle the case when permission is denied
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Camera permission denied.'),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          });
                        },
                        child: const Text(
                          'Scan File',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 98, 147, 101),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
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
      backgroundColor: const Color.fromARGB(255, 98, 147, 101),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0), // Square shape with rounded edges
      ),
      child: Icon(
        Icons.document_scanner_rounded, // Icon resembling "add document"
        color: Colors.white,
        size: screenWidth * 0.08,
      ),
    );
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      // Request the permission if it is not granted
      await Permission.camera.request();
      // Check again the permission status
      status = await Permission.camera.status;
    }
    return status.isGranted; // Return whether permission is granted
  }

  // method to save pdf
  Future<void> scanAndSavePDF() async {
    if (fileName != null || description != null) {
      try {
        final List<String>? scannedImages =
            await CunningDocumentScanner.getPictures();

        if (scannedImages != null && scannedImages.isNotEmpty) {
          final pdf = pw.Document();
          final directory = await getApplicationDocumentsDirectory();
          final pdfFilePath = '${directory.path}/$fileName.pdf';

          for (String imagePath in scannedImages) {
            final image = pw.MemoryImage(File(imagePath).readAsBytesSync());
            pdf.addPage(
                pw.Page(build: (pw.Context context) => pw.Image(image)));
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

          // Format the date so that can be easily readable
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

          print("PDF saved successfully!");

          // Clear the scanned images and reset file details (bila clear automatic keluar error bawah skali)
          setState(() {
            _scannedImages.clear();
            fileName = null;
            description = null;
          });
        } else {
          print("Please scan at least one document.");
        }
      } catch (e) {
        // Handle exceptions
        print("An error occurred while saving the PDF.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You need to fill in the name and description field"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You need to fill in the name and description field"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
