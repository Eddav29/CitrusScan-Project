import 'package:dio/dio.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';

class DiseaseDataApi {
  final Dio _dio;

  DiseaseDataApi(this._dio);

  Future<List<DiseaseData>> getDiseases() async {
    try {
      final response = await _dio.get('/disease');
      final data = response.data as List;
      return data.map((disease) => DiseaseData.fromJson(disease)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<DiseaseData> getDiseaseDetails(int id) async {
    try {
      final response = await _dio.get('/disease/$id');
      final data = response.data;
      return DiseaseData.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final errorData = e.response?.data;
      final errorMessage = errorData is Map
          ? errorData['message'] ?? 'Terjadi kesalahan'
          : 'Terjadi kesalahan';
      return Exception(errorMessage);
    }
    return Exception('Tidak dapat terhubung ke server. Periksa koneksi Anda.');
  }
}