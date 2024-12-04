import 'package:citrus_scan/data/model/history/history.dart';
import 'package:dio/dio.dart';

class HistoryApi {
  final Dio _dio;

  HistoryApi(this._dio);

  Future<List<History>> fetchUserHistory(int userId) async {
    try {
      final response = await _dio.get('/user/$userId/history');
      final data = response.data['data'] as List;
      return data.map((history) => History.fromJson(history)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<HistoryDetail> fetchUserHistoryDetail(int userId, int historyId) async {
    try {
      final response = await _dio.get('/user/$userId/history/$historyId');
      final data = response.data['data'];
      return HistoryDetail.fromJson(data);
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