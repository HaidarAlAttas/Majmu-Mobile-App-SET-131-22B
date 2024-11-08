import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:majmu/components/searchpage_components/searchbar.dart';
import 'package:majmu/screens/content/contentviewer.dart';
import 'package:path_provider/path_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String docs = "";
  List<Map<String, dynamic>> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  // Create a global key for the Scaffold
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  addData() async {
    for (var element in searchResults) {
      FirebaseFirestore.instance.collection("app-content").add(element);
    }
    print("all data is added");
  }

  @override
  Widget build(BuildContext context) {
    // sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 241, 222),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 245, 241, 222),
          title: Text("Search Page"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                MySearchBar(
                  searchController: searchController,
                  onChanged: (value) {
                    setState(() {
                      docs = value;
                    });
                  },
                ),
                Expanded(
                  // build the list on the search page
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('app-content')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No results found.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }

                      final results = snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return {
                          'name': data['name'] ?? 'No Name',
                          'filepath': data['filepath'] ?? '',
                        };
                      }).where((result) {
                        final query = searchController.text.toLowerCase();
                        return result['name'].toLowerCase().contains(query);
                      }).toList();

                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.005,
                              horizontal: screenWidth * 0.04,
                            ),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                title: Text(
                                  result['name'].split('_').length > 1
                                      ? result['name'].split('_')[1]
                                      : result['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  openPDF(
                                    result['filepath'],
                                    result['name'].split('_').length > 1
                                        ? result['name'].split('_')[1]
                                        : result['name'],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> openPDF(String filepath, String folderName) async {
    setState(() {
      isLoading = true;
    });

    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$folderName.pdf';

    try {
      final downloadURL = filepath;

      print("Download URL: $downloadURL");

      await Dio().download(downloadURL, filePath);

      print("Downloaded file path: $filePath");

      Reference fileReference =
          FirebaseStorage.instance.refFromURL(downloadURL);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContentViewer(
            path: filePath,
            name: folderName,
            fileReference: fileReference,
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Swipe downwards',
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.grey[800],
        ),
      );
    } catch (e) {
      print("Error while downloading the PDF: $e");
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
              'Failed to open PDF: please contact the admin in setting page'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<Map<String, dynamic>>> searchByMetadataName(String query) async {
    List<Map<String, dynamic>> results = [];
    CollectionReference mainCollection =
        FirebaseFirestore.instance.collection('app-content');

    QuerySnapshot querySnapshot = await mainCollection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      if (data['name'] != null &&
          data['name'].toString().toLowerCase().contains(query.toLowerCase())) {
        results.add({
          'name': data['name'],
          'filepath': data['filepath'],
        });
      }
    }
    return results;
  }
}
