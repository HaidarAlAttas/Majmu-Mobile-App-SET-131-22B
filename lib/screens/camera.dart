// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

class CameraScan extends StatefulWidget {
  const CameraScan({super.key});

  @override
  State<CameraScan> createState() => _CameraScanState();
}

class _CameraScanState extends State<CameraScan> with WidgetsBindingObserver {
  // create a variable that allows the camera to always be available
  List<CameraDescription> cameras = [];

  // variable for camera
  CameraController? cameraController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // check if there's a camera or not (error handling)
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController();
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  // design of UI for the camera
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),

      // the camera method called
      body: _cameraUI(),
    );
  }

  Widget _cameraUI() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.60,
              width: MediaQuery.sizeOf(context).width * 0.80,
              child: CameraPreview(
                cameraController!,
              ),
            ),
            IconButton(
                onPressed: () async {
                  // to capture the photo
                  XFile picture = await cameraController!.takePicture();

                  // gal package to save the image taken into app photos (configure this to save to firebase)
                  Gal.putImage(
                    picture.path,
                  );
                },
                icon: const Icon(
                  size: 100,
                  Icons.camera,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }

  // method future to call the camera
  Future<void> _setupCameraController() async {
    List<CameraDescription> _cameras = await availableCameras();

    // to check whether the device have a camera or not
    if (_cameras.isNotEmpty) {
      setState(() {
        cameras = _cameras;
        cameraController = CameraController(
          // kalau pakai .first camera belakang, kalau pakai .last camera depan
          _cameras.first,
          ResolutionPreset.high,
        );
      });

      cameraController?.initialize().then((_) {

        // error handling
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError(
        (Object e) {
          print(e);
        },
      );
    }
  }
}
