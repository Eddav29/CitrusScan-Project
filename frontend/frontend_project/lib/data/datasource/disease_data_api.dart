import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:dio/dio.dart';

class DiseaseDataApi {
  final Dio _dio;

  DiseaseDataApi(this._dio);

  // Fungsi untuk mengambil daftar penyakit
  Future<List<DiseaseData>> getDiseases() async {
    try {
      final response =
          await _dio.get('/diseases'); // Panggil endpoint /diseases
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // Mengembalikan list of DiseaseData dengan memetakan data JSON ke dalam objek DiseaseData
        return data.map((json) => DiseaseData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load diseases');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

// Fungsi untuk mengambil detail penyakit beserta langkah perawatannya
  Future<DiseaseData> getDiseaseDetails(String diseaseId) async {
    try {
      final response = await _dio.get('/diseases/$diseaseId');
      if (response.statusCode == 200) {
        final data = response.data;

        return DiseaseData.fromJson(data);
      } else {
        throw Exception('Failed to load disease details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
