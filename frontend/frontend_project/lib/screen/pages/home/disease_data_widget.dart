import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/screen/pages/home/disease_treatment_screen.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/controller/disease_data_controller.dart';

class DiseaseDataWidget extends ConsumerStatefulWidget {
  @override
  _DiseaseDataWidgetState createState() => _DiseaseDataWidgetState();
}

class _DiseaseDataWidgetState extends ConsumerState<DiseaseDataWidget> {
  @override
  void initState() {
    super.initState();
    // Fetch the diseases when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(diseaseDataControllerProvider.notifier).fetchDiseases();
    });
  }

  // Widget for each disease card
  Widget _buildDiseaseCard(DiseaseData disease, BuildContext context) {
    final imageUrl = "http://10.0.2.2:8000/storage/${disease.diseaseImage}";

    return GestureDetector(
      onTap: () {
        // Navigate to DiseaseTreatmentScreen by passing diseaseId instead of the whole object
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DiseaseTreatmentScreen(diseaseId: disease.diseaseId),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback image if loading fails
                  return Center(
                    child: Icon(Icons.error, size: 50, color: Colors.red),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                disease.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final diseaseDataState = ref.watch(diseaseDataControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kategori Penyakit",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        SizedBox(height: 10),
        if (diseaseDataState is DiseaseDataLoading)
          Center(child: CircularProgressIndicator()),
        if (diseaseDataState is DiseaseDataError)
          Center(child: Text('Error: ${diseaseDataState.message}')),
        if (diseaseDataState is DiseaseDataListSuccess)
          diseaseDataState.diseases.isNotEmpty
              ? GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2, // Two columns per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4, // Aspect ratio for good design
                  physics: NeverScrollableScrollPhysics(),
                  children: diseaseDataState.diseases
                      .where((disease) =>
                          disease.name != "Healthy" &&
                          disease.name != "Non Citrus Leaf") // Filter here

                      .map((disease) {
                    return _buildDiseaseCard(disease, context);
                  }).toList(),
                )
              : Center(child: Text('Tidak ada kategori penyakit')),
      ],
    );
  }
}
