// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScan with ChangeNotifier {
  // firebase Storage
  final firebaseStorage = FirebaseStorage.instance;

  // images are stored in firebase as URL'
  List<String> _imageUrls = [];

  // loading status
  bool _isLoading = false;

  // uploading status
  bool _isUploading = false;

  // G E T T E R

  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;

  bool get isUploading => _isUploading;

  // R E A D   I M A G E

  Future<void> fetchImages() async {
    // start loading first...
    _isLoading = true;

    // get the list under the directory userposts/
    final ListResult result =
        await FirebaseStorage.instance.ref("userposts/").list();

    // get the upload URLs for each image
    final urls = Future.wait(
      result.items.map(
        (ref) => ref.getDownloadURL(),
      ),
    );

    // update the urls
    _imageUrls = urls as List<String>;

    // loading is finished
    _isLoading = false;

    // update the UI
    notifyListeners();
  }

  /*
  
  D E L E T E   I M A G E S

  - images are stored like this https://firebasestorage.....userposts/ioshfoaihf
  - so we only wanted the last part of the link eg. userposts/... to delete
  
  */

  Future<void> deleteImages(String imageUrl) async {
    try {
      // remove from local URL
      _imageUrls.remove(imageUrl);

      // get path name and remove from firebase
      final String path = extractPathFromUrl(imageUrl);

      await firebaseStorage.ref(path).delete();
    }

    // handle any errors
    catch (e) {
      print("error deleting images: $e");
    }

    // update the UI
    notifyListeners();
  }

  // to get the last part of the image URL
  String extractPathFromUrl(String url) {
    // uri is used to divide parts inside internet URLs
    Uri uri = Uri.parse(url);

    // extracting the part of url that we needed
    String encodedPath = uri.pathSegments.last;

    // url decoding the last part
    return Uri.decodeComponent(encodedPath);
  }

  // U P L O A D   I M A G E S
  // masukkan method ni nanti bawah post.id

  Future<void> uploadImages(String filepath) async {
    // start loading...
    _isUploading = true;

    // update the UI
    notifyListeners();

    // pick an image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // check if there's any pic
    if (image == null) {
      return; // just return nothing if there's no images
    }
    File file = File(image.path);

    try {
      // define the path in firebase storage
      String filePath = 'userposts/${DateTime.now()}.png';
      filepath = filePath;

      // upload the file in firebase storage
      await firebaseStorage.ref(filePath).putFile(file);

      // after downloading fetch the download url
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      // update the image urls list and UI
      notifyListeners();
    } catch (e) {
      print("error uploading $e");
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
