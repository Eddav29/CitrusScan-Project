import 'package:citrus_scan/screen/pages/scan/result_screen.dart'; // Import result screen
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/widgets/loading_screen.dart'; // Import loading screen

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  String? imagePath;
  bool isCameraInitialized = false; // Store camera initialization status
  bool isLoading = false; // Store loading status
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final firstCamera = cameras!.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    try {
      await _cameraController!.initialize();
      setState(() {
        isCameraInitialized = true; // Update the camera initialization status
      });
    } catch (e) {
      print(e); // Handle any initialization errors
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path; // Save the picked image path
      });
    }
  }

  Future<void> takePicture() async {
    if (_cameraController!.value.isInitialized) {
      setState(() {
        isLoading = true; // Start loading
      });

      try {
        final XFile image = await _cameraController!.takePicture();
        setState(() {
          imagePath = image.path; // Save the captured image path
        });

        // Simulate loading with a delay
        await Future.delayed(const Duration(seconds: 2));
      } catch (e) {
        print(e); // Handle errors if any
      } finally {
        setState(() {
          isLoading = false; // End loading
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan or Pick Image'),
      ),
      body: Column(
        children: [
          if (isLoading)  LoadingScreen(), // Show loading screen
          if (!isLoading) ...[
            if (!isCameraInitialized) // If camera is not initialized
              ElevatedButton(
                onPressed: _initializeCamera,
                child: const Text('Open Camera'),
              ),
            if (isCameraInitialized) ...[
              Expanded(child: CameraPreview(_cameraController!)),
              
              if (imagePath != null) // If image is captured, display it
                Image.file(File(imagePath!)),
            ],
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: takePicture, // Take picture with the camera
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Picture'),
              ),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery, // Pick image from gallery
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick from Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
