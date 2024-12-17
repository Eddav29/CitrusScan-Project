import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/prediction/prediction_state.dart';
import 'package:citrus_scan/provider/provider.dart';

class ScanResultScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const ScanResultScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ScanResultScreenState createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends ConsumerState<ScanResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(predictionControllerProvider.notifier).predict(widget.imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final predictionState = ref.watch(predictionControllerProvider);

    return Scaffold(
      backgroundColor: Color.fromRGBO(234, 245, 239, 1),
      body: Stack(
        children: [
          // Display image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(widget.imagePath),
                height: screenHeight * 0.4,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),

          // Positioned Back Arrow Icon
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.5),
                radius: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF215C3C)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ),

          // Rest of the UI content
          Positioned(
            top: screenHeight * 0.35,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(234, 245, 239, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: _buildContent(predictionState),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PredictionState state) {
    return switch (state) {
      PredictionInitial() => const Center(
          child: Text('Siap untuk memindai gambar'),
        ),
      PredictionLoading() => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Menganalisis gambar...'),
            ],
          ),
        ),
      PredictionError(message: var message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(message),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(predictionControllerProvider.notifier)
                      .predict(widget.imagePath);
                },
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      PredictionSuccess(prediction: var prediction) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Conditional Background Color and Description
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getBackgroundColor(prediction.disease),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/citrus.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prediction.disease,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _getDescriptionText(
                              prediction.disease, prediction.confidence),
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Additional treatment steps if available
            if (prediction.treatment.isNotEmpty)
              ...prediction.treatment.map((step) {
                return Column(
                  children: [
                    buildInfoBox(
                      title: 'Deskripsi',
                      content: step.description,
                      icon: Icons.info,
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Gejala',
                      content: step.symptoms,
                      icon: Icons.warning,
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Solusi',
                      content: step.solutions,
                      icon: Icons.check_circle,
                    ),
                    SizedBox(height: 16),
                    buildInfoBox(
                      title: 'Pencegahan',
                      content: step.prevention,
                      icon: Icons.shield,
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
          ],
        ),
    };
  }

  // Function to determine background color based on disease detection
  Color _getBackgroundColor(String disease) {
    if (disease == "Not Citrus Leaf") {
      return Colors.grey; // Grey for Not Citrus Leaf
    } else if (disease == "Healthy") {
      return Colors.green; // Green for Healthy leaves
    }
    return Colors.red; // Default red color if disease not recognized
  }

  // Function to provide description based on the detected disease
  String _getDescriptionText(String disease, double confidence) {
    if (disease == "Not Citrus Leaf") {
      return "Gambar ini bukan daun jeruk, mohon pastikan gambar yang dipindai benar.";
    } else if (disease == "Healthy") {
      return "Daun ini terdeteksi sehat tanpa tanda-tanda penyakit.";
    }
    return "${(confidence * 100).toStringAsFixed(1)}% daun terdeteksi berpenyakit $disease."; // Default message if unknown disease
  }

  Widget buildInfoBox({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
