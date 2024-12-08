import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citrus_scan/data/model/prediction/prediction.dart';


class PredictionApi {
  final Dio _dio;

  PredictionApi(this._dio);

  Future<Prediction> predict(String imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user');
      
      if (userData == null) {
        throw Exception('User not logged in');
      }

      final user = jsonDecode(userData);
      final userId = user['user_id'];

      if (userId == null) {
        throw Exception('User ID not found');
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath),
        'user_id': userId,
      });

      final response = await _dio.post(
        'http://10.0.2.2:8000/api/predict',
        data: formData,
        options: Options(
          receiveTimeout: Duration(seconds: 100), // Tingkatkan receiveTimeout
        ),
      );

      if (response.statusCode == 200) {
        return Prediction.fromJson(response.data['data']);
      }
      throw Exception(response.data['message'] ?? 'Prediction failed');
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