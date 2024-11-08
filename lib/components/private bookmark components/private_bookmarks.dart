import 'package:flutter/material.dart';
import 'package:majmu/components/private%20bookmark%20components/pdf_viewerpage.dart';
import 'package:pdfx/pdfx.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrivateBookmarks extends StatelessWidget {
  final String fileName;
  final String description;
  final String previewImageUrl;
  final String pdfUrl;
  final String dateCreated;
  final String
      bookmarkId; // Assuming bookmarkId is provided to identify the document

  const PrivateBookmarks({
    Key? key,
    required this.fileName,
    required this.description,
    required this.previewImageUrl,
    required this.pdfUrl,
    required this.dateCreated,
    required this.bookmarkId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewerPage(
                pdfUrl: pdfUrl,
                name: fileName,
                description: description,
              ),
            ),
          );
        },
        child: Container(
          height: screenHeight * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image preview
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  previewImageUrl,
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.3,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 50);
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fileName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        dateCreated,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // More icon with popup menu
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                elevation: 8,
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditDialog(context);
                  } else if (value == 'delete') {
                    _showDeleteConfirmationDialog(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Edit Bookmark'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        const SizedBox(width: 8), // Space between icon and text
                        Text(
                          'Delete Bookmark',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Edit dialog function
  Future<void> _showEditDialog(BuildContext context) async {
    String? updatedFileName = fileName;
    String? updatedDescription = description;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Bookmark',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // field to edit name of the file
              TextField(
                onChanged: (value) => updatedFileName = value,

                // max character
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'File Name',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: TextEditingController(text: fileName),
              ),
              const SizedBox(height: 10),

              // field to update the file description
              TextField(
                onChanged: (value) => updatedDescription = value,

                // max character
                maxLength: 400,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
                controller: TextEditingController(text: description),
              ),
            ],
          ),
          actions: [
            // button to cancel the update
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),

            // button to save updates
            ElevatedButton(
              onPressed: () async {
                final currentUser = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('user-cred')
                    .doc(currentUser)
                    .collection("privateBookmarks")
                    .doc(bookmarkId)
                    .update({
                  'name': updatedFileName,
                  'description': updatedDescription,
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Bookmark',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this bookmark? \n(This action will also remove the bookmark from the cloud storage)',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                _deleteBookmark(context);
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Delete bookmark function
  Future<void> _deleteBookmark(BuildContext context) async {
    try {
      final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Delete PDF file from Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(pdfUrl);
      await storageRef.delete();

      // Delete preview image from Firebase Storage
      final previewImageRef =
          FirebaseStorage.instance.refFromURL(previewImageUrl);
      await previewImageRef.delete();

      // Delete document from Firestore
      await FirebaseFirestore.instance
          .collection('user-cred')
          .doc(currentUserId)
          .collection('privateBookmarks')
          .doc(bookmarkId)
          .delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting bookmark: $e')),
      );
    }
  }
}
