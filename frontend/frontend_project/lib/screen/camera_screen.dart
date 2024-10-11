import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  String? imagePath;
  bool isCameraInitialized = false; // Menyimpan status inisialisasi kamera

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    if (cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      setState(() {
        isCameraInitialized = true; // Kamera berhasil diinisialisasi
      });
    }
  }

  Future<void> takePicture() async {
    if (_cameraController!.value.isInitialized) {
      try {
        final XFile image = await _cameraController!.takePicture();
        setState(() {
          imagePath = image.path; // Simpan path gambar yang diambil
        });
      } catch (e) {
        print(e); // Tangani error jika terjadi
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: Column(
        children: [
          if (!isCameraInitialized) // Jika kamera belum diinisialisasi
            ElevatedButton(
              onPressed: initializeCamera,
              child: Text('Buka Kamera'),
            ),
          if (isCameraInitialized) ...[
            Expanded(child: CameraPreview(_cameraController!)),
            ElevatedButton(
              onPressed: takePicture,
              child: Text('Ambil Foto'),
            ),
            if (imagePath != null) // Jika gambar sudah diambil, tampilkan
              Image.file(File(imagePath!)),
          ],
        ],
      ),
    );
  }
}
