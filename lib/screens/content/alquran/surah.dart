// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late Future<ListResult> futureFolders;

  // Predefined list of 114 Surahs in the correct order (Quranic order)
  List<String> quranSurahOrder = [
    '001_Al-Fatiha',
    '002_Al-Baqarah',
    '003_Al-Imran',
    '004_An-Nisa',
    '005_Al-Maidah',
    '006_Al-Anam',
    '007_Al-Araf',
    '008_Al-Anfal',
    '009_At-Tawbah',
    '010_Yunus',
    '011_Hud',
    '012_Yusuf',
    '013_Ar-Rad',
    '014_Ibrahim',
    '015_Al-Hijr',
    '016_An-Nahl',
    '017_Al-Isra',
    '018_Al-Kahf',
    '019_Maryam',
    '020_Ta-Ha',
    '021_Al-Anbiya',
    '022_Al-Hajj',
    '023_Al-Muminun',
    '024_An-Nur',
    '025_Al-Furqan',
    '026_Ash-Shuara',
    '027_An-Naml',
    '028_Al-Qasas',
    '029_Al-Ankabut',
    '030_Ar-Rum',
    '031_Luqman',
    '032_As-Sajda',
    '033_Al-Ahzab',
    '034_Saba',
    '035_Fatir',
    '036_Yasin',
    '037_As-Saffat',
    '038_Sad',
    '039_Az-Zumar',
    '040_Ghafir',
    '041_Fussilat',
    '042_Ash-Shura',
    '043_Az-Zukhruf',
    '044_Ad-Dukhan',
    '045_Al-Jathiyah',
    '046_Al-Ahqaf',
    '047_Muhammad',
    '048_Al-Fath',
    '049_Al-Hujurat',
    '050_Qaf',
    '051_Adh-Dhariyat',
    '052_At-Tur',
    '053_An-Najm',
    '054_Al-Qamar',
    '055_Ar-Rahman',
    '056_Al-Waqia',
    '057_Al-Hadid',
    '058_Al-Mujadila',
    '059_Al-Hashr',
    '060_Al-Mumtahina',
    '061_As-Saff',
    '062_Al-Jumuah',
    '063_Al-Munafiqun',
    '064_At-Taghabun',
    '065_At-Talaq',
    '066_At-Tahrim',
    '067_Al-Mulk',
    '068_Al-Qalam',
    '069_Al-Haaqqa',
    '070_Al-Maarij',
    '071_Nuh',
    '072_Al-Jinn',
    '073_Al-Muzzammil',
    '074_Al-Muddaththir',
    '075_Al-Qiyamah',
    '076_Al-Insan',
    '077_Al-Mursalat',
    '078_An-Naba',
    '079_An-Naziat',
    '080_Abasa',
    '081_At-Takwir',
    '082_Al-Infitar',
    '083_Al-Mutaffifin',
    '084_Al-Inshiqaq',
    '085_Al-Buruj',
    '086_At-Tariq',
    '087_Al-Ala',
    '088_Al-Ghashiyah',
    '089_Al-Fajr',
    '090_Al-Balad',
    '091_Ash-Shams',
    '092_Al-Lail',
    '093_Ad-Duha',
    '094_Ash-Sharh',
    '095_At-Tin',
    '096_Al-Alaq',
    '097_Al-Qadr',
    '098_Al-Bayyina',
    '099_Az-Zalzalah',
    '100_Al-Adiyat',
    '101_Al-Qariah',
    '102_At-Takathur',
    '103_Al-Asr',
    '104_Al-Humazah',
    '105_Al-Fil',
    '106_Quraysh',
    '107_Al-Maun',
    '108_Al-Kawthar',
    '109_Al-Kafirun',
    '110_An-Nasr',
    '111_Al-Masad',
    '112_Al-Ikhlas',
    '113_Al-Falaq',
    '114_An-Nas'
  ];

  @override
  void initState() {
    super.initState();
    futureFolders =
        FirebaseStorage.instance.ref('/alqurankareem/surah').listAll();
  }

  // Method to open PDF
  Future<void> openPDF(
      BuildContext context, Reference ref, String folderName) async {
    final dir = await getDownloadsDirectory();
    final filePath = '${dir!.path}/${ref.name}';

    try {
      final downloadURL = await ref.getDownloadURL();
      await Dio().download(downloadURL, filePath);

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
          child: CircularProgressIndicator(), // Loading spinner
        );
      },
    );

    try {
      // Fetch the list of files in the folder
      final files = await folder.listAll();
      final pdfFiles =
          files.items.where((file) => file.name.endsWith('.pdf')).toList();
      String folderName = folder.name;

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
                            child: CircularProgressIndicator(),
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

  String getSurahName(String folderName) {
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

                // Sort folders based on predefined Quranic Surah order
                folders.sort((a, b) {
                  int indexA = quranSurahOrder.indexOf(a.name);
                  int indexB = quranSurahOrder.indexOf(b.name);

                  if (indexA == -1) indexA = quranSurahOrder.length;
                  if (indexB == -1) indexB = quranSurahOrder.length;

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
                                getSurahName(folder.name),
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
