import 'package:citrus_scan/data/model/prediction/prediction.dart';
import 'package:dio/dio.dart';


class PredictionApi {
  final Dio _dio;

  PredictionApi(this._dio);

  Future<Prediction> predict({
    required String image,
  }) async {
    try {
      final response = await _dio.post(
        '/predict',
        data: {
          'image': image,
        },
      );

      return Prediction.fromJson(response.data);
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