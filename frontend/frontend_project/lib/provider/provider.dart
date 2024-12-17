import 'dart:io';
import 'package:citrus_scan/controller/prediction_controller.dart';
import 'package:citrus_scan/controller/history_controller.dart';
import 'package:citrus_scan/controller/auth_controller.dart';
import 'package:citrus_scan/controller/disease_data_controller.dart';
import 'package:citrus_scan/controller/profile_controller.dart';
import 'package:citrus_scan/data/datasource/disease_data_api.dart';
import 'package:citrus_scan/data/datasource/prediction_api.dart';
import 'package:citrus_scan/data/datasource/auth_api.dart';
import 'package:citrus_scan/data/datasource/profile_api.dart';
import 'package:citrus_scan/data/datasource/history_api.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data.dart';
import 'package:citrus_scan/data/model/disease_data/disease_data_state.dart';
import 'package:citrus_scan/data/model/history/history_state.dart';
import 'package:citrus_scan/data/model/prediction/prediction_state.dart';
import 'package:citrus_scan/data/model/user/profile/profile_state.dart';
import 'package:citrus_scan/data/model/user/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    // baseUrl for your API
    // baseUrl: Platform.isAndroid ? 'http://backend.citrus-scan.my.id/api' : '',
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:8000/api'
        : 'http://127.0.0.1:8000/api',
    contentType: 'application/json',
    headers: {
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 60), // Time to connect
    receiveTimeout: const Duration(seconds: 60), // Time to receive data
  ));

  // Optionally add logging for debugging
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    error: true,
  ));

  return dio;
});

final predictionApiProvider = Provider<PredictionApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PredictionApi(dio);
});

final diseaseDataApiProvider = Provider<DiseaseDataApi>((ref) {
  final dio = ref.watch(dioProvider);
  return DiseaseDataApi(dio);
});

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
});

final profileApiProvider = Provider<ProfileApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileApi(dio);
});

final historyApiProvider = Provider<HistoryApi>((ref) {
  final dio = ref.watch(dioProvider);
  return HistoryApi(dio);
});

// Controller Providers
final predictionControllerProvider =
    StateNotifierProvider<PredictionController, PredictionState>((ref) {
  final predictionApi = ref.watch(predictionApiProvider);
  return PredictionController(predictionApi);
});

final diseaseDataControllerProvider =
    StateNotifierProvider<DiseaseDataController, DiseaseDataState>((ref) {
  final diseaseApi = ref.watch(diseaseDataApiProvider);
  return DiseaseDataController(diseaseApi);
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authApi = ref.watch(authApiProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthController(authApi, prefs);
});

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
  final profileApi = ref.watch(profileApiProvider);
  return ProfileController(profileApi);
});

final historyControllerProvider =
    StateNotifierProvider<HistoryController, HistoryState>((ref) {
  final historyApi = ref.watch(historyApiProvider);
  return HistoryController(historyApi);
});

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize this in main.dart using override');
});

// Initialize SharedPreferences