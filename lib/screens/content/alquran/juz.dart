// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';

class JuzPage extends StatefulWidget {
  const JuzPage({super.key});

  @override
  State<JuzPage> createState() => _JuzPageState();
}

class _JuzPageState extends State<JuzPage> {
  late Future<ListResult> futureFolders;

  // Predefined list of 30 Juz in the format "001_ Juz 1"
  List<String> quranJuzOrder = List.generate(30, (index) {
    final juzNumber = index + 1;
    return '${juzNumber.toString().padLeft(3, '0')}_ Juz $juzNumber';
  });

  @override
  void initState() {
    super.initState();
    futureFolders =
        FirebaseStorage.instance.ref('/alqurankareem/juz').listAll();
  }

  // Method to open PDF
  Future<void> openPDF(
      BuildContext context, Reference ref, String surahName) async {
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
            name: surahName,
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
    String surahName = getJuzName(folder.name);

    if (pdfFiles.length == 1) {
      await openPDF(context, pdfFiles[0], surahName);
    } else if (pdfFiles.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text(getJuzName(folder.name))),
            body: ListView.builder(
              itemCount: pdfFiles.length,
              itemBuilder: (context, index) {
                final file = pdfFiles[index];
                return GestureDetector(
                  onTap: () async {
                    await openPDF(context, file, surahName);
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

  String getJuzName(String folderName) {
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

                // Sort folders based on predefined Quranic Juz order
                folders.sort((a, b) {
                  int indexA = quranJuzOrder.indexOf(getJuzName(a.name));
                  int indexB = quranJuzOrder.indexOf(getJuzName(b.name));

                  if (indexA == -1) indexA = quranJuzOrder.length;
                  if (indexB == -1) indexB = quranJuzOrder.length;

                  return indexA.compareTo(indexB);
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
                                getJuzName(folder.name),
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
