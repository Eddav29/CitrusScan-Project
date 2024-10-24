import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio dio;

  // Base URL sesuai dengan Laravel Anda
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    // Tambahkan interceptor untuk logging
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      error: true,
    ));
  }

  Future<bool> testConnection() async {
    try {
      final response = await dio.get('/test-connection');
      print('Response data: ${response.data}');
      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Dio Error: ');
      print('Error Type: ${e.type}');
      print('Error Message: ${e.message}');
      print('Error Response: ${e.response}');
      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timeout - Check if Laravel server is running');
      }
      if (e.type == DioExceptionType.connectionError) {
        print('Connection error - Check your API URL and Laravel server');
      }
      return false;
    } catch (e) {
      print('Unknown error: $e');
      return false;
    }
  }
}