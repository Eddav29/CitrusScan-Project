import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanOptionsModal extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;

  const ScanOptionsModal({Key? key, required this.onImageSourceSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Ambil dari Kamera'),
            onTap: () {
              Navigator.pop(context); // Menutup modal
              onImageSourceSelected(ImageSource.camera); // Mengembalikan sumber kamera
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Ambil dari Galeri'),
            onTap: () {
              Navigator.pop(context); // Menutup modal
              onImageSourceSelected(ImageSource.gallery); // Mengembalikan sumber galeri
            },
          ),
        ],
      ),
    );
  }
}
