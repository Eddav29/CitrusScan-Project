import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/prediction/prediction_state.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/provider/provider.dart';
class ScanResultScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const ScanResultScreen({super.key, required this.imagePath});

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(widget.imagePath),
                height: screenHeight * 0.45,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(234, 245, 239, 1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: _buildContent(predictionState),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(predictionControllerProvider.notifier).predict(widget.imagePath);
                  },
                  child: const Text('Coba Lagi'),
                ),
              ),
            ],
          ),
        ),
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
                ref.read(predictionControllerProvider.notifier).predict(widget.imagePath);
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
      PredictionSuccess(prediction: var prediction) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prediction.disease,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hasil Prediksi: ${(prediction.confidence * 100).toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          if (prediction.secondBest != null) ...[
            const SizedBox(height: 8),
            Text(
              'Kemungkinan lain: ${prediction.secondBest!['name']} (${(prediction.secondBest!['confidence'] * 100).toStringAsFixed(1)}%)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
          const SizedBox(height: 24),
          _buildDiseaseDetails(prediction.diseaseId),
        ],
      ),
    };
  }

  Widget _buildDiseaseDetails(String diseaseId) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(diseaseDataControllerProvider);
        
        return switch (state) {
          DiseaseDataInitial() => const SizedBox(),
          DiseaseDataLoading() => const Center(child: CircularProgressIndicator()),
          DiseaseDataError(message: var message) => Center(child: Text('Error: $message')),
          DiseaseDataDetailSuccess(diseaseDetail: var disease) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                disease.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Description:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(disease.description ?? 'No description available'),
              const SizedBox(height: 16),
              Text(
                'Treatment:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(disease.treatment ?? 'No treatment information available'),
            ],
          ),
          _ => const SizedBox(),
        };
      },
    );
  }
}