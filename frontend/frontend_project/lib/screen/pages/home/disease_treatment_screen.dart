import 'dart:convert';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiseaseTreatmentScreen extends StatefulWidget {
  final String diseaseId;

  DiseaseTreatmentScreen({required this.diseaseId});

  @override
  _DiseaseTreatmentScreenState createState() => _DiseaseTreatmentScreenState();
}

class _DiseaseTreatmentScreenState extends State<DiseaseTreatmentScreen> {
  late DiseaseData _diseaseData;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchDiseaseData();
  }

  Future<void> _fetchDiseaseData() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/diseases/${widget.diseaseId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _diseaseData = DiseaseData.fromJson(json.decode(response.body));
        _isLoading = false;
      });
    } else {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan gambar penyakit
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _hasError
                      ? Center(
                          child: Icon(Icons.error, size: 50, color: Colors.red))
                      : Image.network(
                          "http://10.0.2.2:8000/storage/${_diseaseData.diseaseImage}",
                          height: screenHeight * 0.45,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(Icons.error,
                                  size: 50, color: Colors.red),
                            );
                          },
                        ),
              SizedBox(height: 0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menampilkan nama penyakit dan perawatan secara dinamis
                    _isLoading || _hasError
                        ? Container() // Placeholder to avoid error while loading
                        : Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(Icons.bug_report,
                                      size: 30, color: Colors.white),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _diseaseData.name,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        _diseaseData.treatment ??
                                            'No treatment available',
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
                    SizedBox(width: 16),
                    // Menampilkan langkah-langkah perawatan (deskripsi, gejala, solusi, pencegahan)
                    if (!_isLoading && !_hasError)
                      ..._diseaseData.steps.map((step) {
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF215C3C),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(0, 56),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.center_focus_strong,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Deteksi Lagi',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
