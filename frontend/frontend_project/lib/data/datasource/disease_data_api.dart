import 'package:dio/dio.dart';

class DiseaseDataApi {
  final Dio _dio;
  
  DiseaseDataApi(this._dio);

  Future getDiseaseData() async{
    try{
      final response = await _dio.get(
      '/disease',
      data: {
        
         // sending the generated token
      },
    );

    }on DioException catch (e) {
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