// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

class HomepageContent extends StatefulWidget {
  final String folder;

  const HomepageContent({
    super.key,
    required this.folder,
  });

  @override
  State<HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<HomepageContent> {
  late Future<ListResult> futureFolders;

  // letak index ii for file ii lain

  @override
  void initState() {
    super.initState();
    futureFolders = FirebaseStorage.instance.ref(widget.folder).listAll();
  }

  // Method to open PDF

  Future<void> openPDF(
      BuildContext context, Reference ref, String folderName) async {
    // Show loading indicator while the file is being downloaded
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal while loading
      builder: (BuildContext context) {
        return Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(
                  color: Colors.green,
                ),
        );
      },
    );

    // Use the Temporary Directory on iOS
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/${ref.name}';

    try {
      // Get the download URL and download the file using Dio
      final downloadURL = await ref.getDownloadURL();
      await Dio().download(downloadURL, filePath);

      // Close the loading dialog once the download is complete
      Navigator.of(context, rootNavigator: true).pop();

      // Navigate to ContentViewer to display the PDF
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContentViewer(
            path: filePath,
            name: folderName, // Pass the folder name to ContentViewer
            fileReference: ref, // Pass the file reference
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Swipe downwards',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.grey[800],
        ),
      );
    } catch (e) {
      // Close the loading dialog in case of an error
      Navigator.of(context, rootNavigator: true).pop();
      print("Error while downloading the PDF: $e");

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load the PDF: $e'),
        ),
      );
    }
  }

  // Method to open folder and handle automatic PDF opening
  Future<void> openFolder(BuildContext context, Reference folder) async {
    // Show loading indicator while the file is being fetched
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal while loading
      builder: (BuildContext context) {
        return Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(
                  color: Colors.green,
                ), // Loading spinner
        );
      },
    );

    try {
      // Fetch the list of files in the folder
      final ListResult files = await folder.listAll();
      final List<Reference> pdfFiles =
          files.items.where((file) => file.name.endsWith('.pdf')).toList();

      if (pdfFiles.isEmpty) {
        Navigator.of(context, rootNavigator: true)
            .pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No PDF files found in this folder.'),
          ),
        );
        return;
      }

      // Retrieve metadata and find the latest file
      Reference? latestFile;
      DateTime? latestTime;

      // iterate over each file to find the latest one
      for (var file in pdfFiles) {
        final metadata = await file.getMetadata();
        if (latestTime == null || metadata.timeCreated!.isAfter(latestTime)) {
          latestFile = file;
          latestTime = metadata.timeCreated;
        }
      }

      // Close the loading dialog once the latest file is identified
      Navigator.of(context, rootNavigator: true).pop();

      if (latestFile != null) {
        // Open the latest PDF file directly
        await openPDF(
            context, latestFile, folder.name); // folder.name sebab nak elak
      }
    } catch (e) {
      // Close the loading dialog in case of an error
      Navigator.of(context, rootNavigator: true).pop();
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load the latest file: $e'),
        ),
      );
    }
  }

  String getName(String folderName) {
    return folderName.split('_').sublist(1).join('_');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 241, 222),

      // appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        // button to go back
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),

      // content inside
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: FutureBuilder<ListResult>(
          future: futureFolders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final folders = snapshot.data!.prefixes;

              // susunan content
              List<String> contentOrder = List.generate(30, (index) {
                final contentNumber = index + 1;
                return '${contentNumber.toString().padLeft(3, '0')}_ Juz $contentNumber';
              });

              return ListView.builder(
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];

                  return GestureDetector(
                    onTap: () async {
                      await openFolder(context, folder);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              getName(folder.name),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.navigate_next_rounded),
                            onPressed: () async {
                              await openFolder(context, folder);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(
                      color: Colors.green,
                    ),
            );
          },
        ),
      ),
    );
  }
}
