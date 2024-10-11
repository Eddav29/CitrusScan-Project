import 'package:citrus_scan/screen/result_screen.dart'; // impor halaman baru
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller?.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _navigateToResultScreen(); // pindah ke halaman hasil setelah pilih gambar
    }
  }

  Future<void> _takePictureWithCamera() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      setState(() {
        _image = File(image.path);
      });
      _navigateToResultScreen(); // pindah ke halaman hasil setelah ambil gambar
    } catch (e) {
      print(e);
    }
  }

  void _navigateToResultScreen() async {
    if (_image != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(image: _image!), // kirim gambar ke halaman baru
        ),
      );
      // Reset _image to null and reinitialize the camera when back to this screen
      setState(() {
        _image = null;
        _initializeCamera(); // Inisialisasi ulang kamera
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan or Pick Image'),
      ),
      body: Column(
        children: [
          if (_image == null) ...[
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: CameraPreview(_controller!), // Preview kamera
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Image.file(_image!), // Menampilkan gambar yang diambil/dipilih
            ),
          ],
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _takePictureWithCamera, // Ambil gambar dengan kamera
                icon: Icon(Icons.camera_alt),
                label: Text('Take Picture'),
              ),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery, // Pilih gambar dari galeri
                icon: Icon(Icons.photo_library),
                label: Text('Pick from Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
