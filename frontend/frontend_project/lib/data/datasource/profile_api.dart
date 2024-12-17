import 'package:dio/dio.dart';
import 'package:citrus_scan/data/model/user/user.dart';

class ProfileApi {
  final Dio _dio;

  ProfileApi(this._dio);

  Future<User> getProfile(String token) async {
    try {
      final response = await _dio.get(
        '/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return User.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> updateProfile(String token,
      {String? name, String? email}) async {
    try {
      final response = await _dio.put(
        '/profile',
        data: {
          if (name != null) 'name': name,
          if (email != null) 'email': email,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return User.fromJson(response.data['user']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

    Future<void> updatePassword(String token, String oldPassword, String newPassword) async {
    try {
      final response = await _dio.put(
        '/update-password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update password');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final errorData = e.response?.data;
      final errorMessage = errorData is Map
          ? errorData['error'] ?? 'Terjadi kesalahan'
          : 'Terjadi kesalahan';
      return Exception(errorMessage);
    }
    return Exception('Tidak dapat terhubung ke server. Periksa koneksi Anda.');
  }
}
