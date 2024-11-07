// lib/data/datasource/auth_api.dart
import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    required String passwordConfirmation,
    required String emailVerifiedAt, // added this parameter
    required String rememberToken, // added this parameter
  }) async {
    final response = await _dio.post(
      '/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'password_confirmation': passwordConfirmation,
        'email_verified_at': emailVerifiedAt, // sending the current date
        'remember_token': rememberToken, // sending the generated token
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout({required String token}) async {
    try {
      await _dio.post(
        '/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
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
