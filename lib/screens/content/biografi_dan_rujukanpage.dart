// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BiographiesnReferencePage extends StatefulWidget {
  const BiographiesnReferencePage({super.key});

  @override
  State<BiographiesnReferencePage> createState() =>
      _BiographiesnReferencePageState();
}

class _BiographiesnReferencePageState extends State<BiographiesnReferencePage> {
  late Future<ListResult> futureFolders;

  @override
  void initState() {
    super.initState();
    futureFolders =
        FirebaseStorage.instance.ref('/biographiesandreferences').listAll();
  }

  // Method to open PDF
  Future<void> openPDF(
      BuildContext context, Reference ref, String folderName) async {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/${ref.name}';

    try {
      final downloadURL = await ref.getDownloadURL();
      await Dio().download(downloadURL, filePath);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContentViewer(
            path: filePath,
            name: folderName, // Pass the folder name to ContentViewer
          ),
        ),
      );
    } catch (e) {
      print("Error while downloading the PDF: $e");
    }
  }

  // Method to open folder and handle automatic PDF opening
  Future<void> openFolder(BuildContext context, Reference folder) async {
    final files = await folder.listAll();
    final pdfFiles =
        files.items.where((file) => file.name.endsWith('.pdf')).toList();
    String folderName = folder.name;

    if (pdfFiles.length == 1) {
      await openPDF(context, pdfFiles[0], folderName);
    } else if (pdfFiles.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text(folderName)),
            body: ListView.builder(
              itemCount: pdfFiles.length,
              itemBuilder: (context, index) {
                final file = pdfFiles[index];
                return GestureDetector(
                  onTap: () async {
                    await openPDF(context, file, folderName);
                  },
                  child: ListTile(
                    title: Text(file.name),
                    trailing: Icon(Icons.navigate_next_rounded),
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No PDF files found in this folder.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 241, 222),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03),
          child: FutureBuilder<ListResult>(
            future: futureFolders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final folders = snapshot.data!.prefixes;

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
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
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
                                folder.name, // Display the folder name
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

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
