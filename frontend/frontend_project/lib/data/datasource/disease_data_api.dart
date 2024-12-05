import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:dio/dio.dart';

class DiseaseDataApi {
  final Dio _dio;

  DiseaseDataApi(this._dio);

  Future<List<DiseaseData>> getDiseases() async {
    try {
      final response = await _dio.get('/disease');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => DiseaseData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load diseases');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to connect to server');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  Future<DiseaseDetail> getDiseaseDetails(String id) async {
    try {
      final response = await _dio.get('/disease/$id');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return DiseaseDetail(
          name: data['name'],
          description: data['description'],
          treatment: data['treatment'],
          steps: (data['steps'] as List)
              .map((step) => TreatmentStep.fromJson(step))
              .toList(),
        );
      } else {
        throw Exception('Failed to load disease details');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to connect to server');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}