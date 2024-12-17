import 'dart:io';
import 'package:citrus_scan/screen/pages/history/scan_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/provider/provider.dart';

class DetailHistoryScreen extends ConsumerStatefulWidget {
  final String userId;
  final String predictionId;

  const DetailHistoryScreen(
      {Key? key, required this.userId, required this.predictionId})
      : super(key: key);

  @override
  _DetailHistoryScreenState createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends ConsumerState<DetailHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(historyControllerProvider.notifier)
          .fetchHistoryDetail(widget.userId, widget.predictionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final historyState = ref.watch(historyControllerProvider);

    return Scaffold(
      backgroundColor: Color.fromRGBO(234, 245, 239, 1),
      body: Stack(
        children: [
          // Display image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image for history
              if (historyState is HistoryDetailSuccess)
                Image.network(
                  historyState.detail.imagePath,
                  height: screenHeight * 0.4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Placeholder jika gambar gagal dimuat
                    return Container(
                      height: screenHeight * 0.4,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    );
                  },
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
                    // Kembali ke halaman riwayat dengan userId
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScanHistoryScreen(), // Gantilah ScanHistoryScreen dengan halaman sebelumnya Anda
                      ),
                    );
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
                child: _buildContent(historyState),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(HistoryState state) {
    // Handle only the success state
    if (state is HistoryDetailSuccess) {
      var detail = state.detail;

      // Get background color and description
      Color backgroundColor = _getBackgroundColor(detail.diseaseName);
      String descriptionText =
          _getDescriptionText(detail.diseaseName, detail.confidence);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Disease information box
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor, // Dynamic background color
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
                        detail.diseaseName,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        descriptionText,
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

          // Steps are only displayed if the disease is NOT "Not Citrus Leaf"
          if (detail.diseaseName != "Not Citrus Leaf") ...[
            const SizedBox(height: 16),
            for (var step in detail.steps) ...[
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
          ],
        ],
      );
    }

    return const Center(child: Text('State not recognized'));
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
