import 'dart:io';
import 'package:citrus_scan/controller/history_controller.dart';
import 'package:citrus_scan/controller/prediction_controller.dart';
import 'package:citrus_scan/controller/auth_controller.dart';
import 'package:citrus_scan/controller/disease_data_controller.dart';
import 'package:citrus_scan/data/datasource/disease_data_api.dart';
import 'package:citrus_scan/data/datasource/history_api.dart';
import 'package:citrus_scan/data/datasource/prediction_api.dart';
import 'package:citrus_scan/data/datasource/auth_api.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/data/model/prediction/prediction_state.dart';
import 'package:citrus_scan/data/model/user/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:8000/api'
        : 'http://127.0.0.1:8000/api',
    contentType: 'application/json',
    headers: {
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    error: true,
  ));

  return dio;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize this in your app\'s bootstrap');
});

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authApi = ref.watch(authApiProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthController(authApi, prefs);
});

final diseaseDataApiProvider = Provider<DiseaseDataApi>((ref) {
  final dio = ref.watch(dioProvider);
  return DiseaseDataApi(dio);
});

final diseaseDataControllerProvider =
    StateNotifierProvider<DiseaseDataController, DiseaseDataState>((ref) {
  final diseaseDataApi = ref.watch(diseaseDataApiProvider);
  return DiseaseDataController(diseaseDataApi);
});

final predictionApiProvider = Provider<PredictionApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PredictionApi(dio);
});

final predictionControllerProvider =
    StateNotifierProvider<PredictionController, PredictionState>((ref) {
  final predictionApi = ref.watch(predictionApiProvider);
  return PredictionController(predictionApi);
});

final historyApiProvider = Provider<HistoryApi>((ref) {
  final dio = ref.watch(dioProvider);
  return HistoryApi(dio);
});

final historyControllerProvider =
    StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final historyApi = ref.watch(historyApiProvider);
  return HistoryController(historyApi);
});