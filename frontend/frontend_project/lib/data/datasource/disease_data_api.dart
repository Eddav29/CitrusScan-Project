import 'package:dio/dio.dart';

class DiseaseDataApi {
  final Dio _dio;

  DiseaseDataApi(this._dio);

  Future<List<dynamic>> getDiseases() async {
    try {
      final response = await _dio.get('/disease');
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getDiseaseDetails(int id) async {
    try {
      final response = await _dio.get('/disease/$id');
      return response.data;
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