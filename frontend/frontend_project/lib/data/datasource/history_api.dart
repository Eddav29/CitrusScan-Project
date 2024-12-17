import 'package:dio/dio.dart';
import 'package:citrus_scan/data/model/history/history.dart';

class HistoryApi {
  final Dio _dio;

  HistoryApi(this._dio);

  Future<List<History>> fetchUserHistory(String userId) async {
    try {
      final response = await _dio.get('/user-history/$userId');

      if (response.data['data'] == null) {
        return [];
      }

      final data = response.data['data'] as List;
      return data
          .map((history) => History.fromJson({
                'prediction_id': history['prediction_id'],
                'disease_name': history['disease_name'],
                'treatment': history['treatment'],
                'created_at': history['created_at'],
                'image_path': history['image_path'],
              }))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<HistoryDetail> fetchUserHistoryDetail(
      String userId, String predictionId) async {
    try {
      final response =
          await _dio.get('/user-history/$userId/history/$predictionId');
      final data = response.data['data'];

      return HistoryDetail(
        diseaseName: data['disease_name'],
        confidence: data['confidence']?.toDouble(),
        imagePath: data['image_path'],
        treatment: data['treatment'],
        steps: (data['steps'] as List)
            .map((step) => TreatmentStep.fromJson(step))
            .toList(),
        createdAt: data['created_at'],
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final errorData = e.response?.data;
      if (errorData is Map) {
        if (e.response?.statusCode == 404) {
          final message = errorData['message'];
          if (message == 'User not found') {
            return Exception('User not found');
          } else if (message == 'No history found for this user') {
            return Exception('No history found');
          } else if (message == 'History not found for this user') {
            return Exception('History detail not found');
          }
        }
        return Exception(errorData['message'] ?? 'An error occurred');
      }
      return Exception('An error occurred');
    }
    return Exception('Could not connect to server');
  }
}
