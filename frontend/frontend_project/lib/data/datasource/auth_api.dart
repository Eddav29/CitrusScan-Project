// lib/data/datasource/auth_api.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

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

      return {
        'access_token': response.data['access_token'],
        'token_type': response.data['token_type'],
        'user': response.data['user'],
      };
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
Future<Map<String, dynamic>> register({
  required String email,
  required String password,
  required String name,
  required String passwordConfirmation,
  String? emailVerifiedAt,
  String? rememberToken,
}) async {
  try {
    final response = await _dio.post(
      '/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'password_confirmation': passwordConfirmation,
      },
    );

    if (response.statusCode == 201 && response.data['user'] != null) {
      return response.data;
    } else {
      throw Exception('Gagal menyimpan akun ke database');
    }
  } on DioException catch (e) {
    throw _handleError(e);
  }
}


  Future<void> logout() async {
    try {
      await _dio.post('/logout');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      await prefs.remove('token');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('/profile');
      return response.data['user'];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? email,
  }) async {
    try {
      final response = await _dio.post(
        '/profile/update',
        data: {
          if (name != null) 'name': name,
          if (email != null) 'email': email,
        },
      );
      return response.data['user'];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      await _dio.post(
        '/profile/password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final errorData = e.response?.data;
      if (errorData is Map) {
        if (errorData.containsKey('errors')) {
          // Laravel validation errors
          final errors = errorData['errors'] as Map;
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return Exception(firstError.first);
          }
        }
        return Exception(errorData['message'] ?? 'An error occurred');
      }
      return Exception('An error occurred');
    }
    return Exception('Could not connect to server');
  }
}
