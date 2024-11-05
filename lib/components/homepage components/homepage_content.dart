// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';

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
    // Use the Temporary Directory on iOS
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/${ref.name}';

    try {
      // Get the download URL and download the file using Dio
      final downloadURL = await ref.getDownloadURL();
      await Dio().download(downloadURL, filePath);

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
    } catch (e) {
      print("Error while downloading the PDF: $e");
    }
  }

  // Method to open folder and handle automatic PDF opening
  Future<void> openFolder(BuildContext context, Reference folder) async {
    // Show loading indicator while the files are being fetched
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal while loading
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ), // Loading spinner
        );
      },
    );

    try {
      // Fetch the list of files in the folder
      final files = await folder.listAll();
      final pdfFiles =
          files.items.where((file) => file.name.endsWith('.pdf')).toList();
      String folderName = getName(folder.name);

      // Close the loading dialog once files are fetched
      Navigator.of(context, rootNavigator: true).pop();

      if (pdfFiles.length == 1) {
        // Open the single PDF file directly
        await openPDF(context, pdfFiles[0], folderName);
      } else if (pdfFiles.isNotEmpty) {
        // Navigate to a new screen with a list of PDF files if more than one is found
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
                      // Show loading indicator when opening PDF
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                            ),
                          );
                        },
                      );
                      await openPDF(context, file, folderName);
                      // Close the loading dialog after opening PDF
                      Navigator.of(context, rootNavigator: true).pop();
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
        // Show a message if no PDF files are found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No PDF files found in this folder.'),
          ),
        );
      }
    } catch (e) {
      // Close the loading dialog in case of an error
      Navigator.of(context, rootNavigator: true).pop();
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load files: $e'),
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

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 241, 222),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          // button to go back
          leading: GestureDetector(
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

                // susun surah
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
                  child: CircularProgressIndicator(
                color: Colors.green,
              ));
            },
          ),
        ),
      ),
    );
  }
}
