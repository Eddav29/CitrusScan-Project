// lib/controller/auth_controller.dart
import 'dart:convert';
import 'package:citrus_scan/data/model/user/auth_state.dart';
import 'package:citrus_scan/data/model/user/user.dart';
import 'package:citrus_scan/services/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/datasource/auth_api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthApi _authApi;
  final SharedPreferencesService _prefsService;

  AuthController(this._authApi, this._prefsService) : super(AuthState()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final token = await _prefsService.getToken();
    final user = await _prefsService.getUser();

    if (token != null && user != null) {
      state = state.copyWith(
        token: token,
        user: user,
      );
    }
  }


  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String passwordConfirmation,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final rememberToken = _generateRememberToken();
      final emailVerifiedAt = DateTime.now().toIso8601String();

      final response = await _authApi.register(
        email: email,
        password: password,
        name: name,
        passwordConfirmation: passwordConfirmation,
        emailVerifiedAt: emailVerifiedAt,
        rememberToken: rememberToken,
      );

      final user = User.fromJson(response);
      final token = response['token'];

      await _prefsService.setToken(token);
      await _prefsService.setUser(user);

      state = state.copyWith(
        token: token,
        user: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  String _generateRememberToken() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response = await _authApi.login(
        email: email,
        password: password,
      );

      final user = User.fromJson(response['user'] as Map<String, dynamic>);
      final token = response['token'] as String;

      await _prefsService.setToken(token);
      await _prefsService.setUser(user);

      state = state.copyWith(
        isLoading: false,
        user: user,
        token: token,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _prefsService.clearAll();
      state = AuthState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  bool get isAuthenticated => state.isAuthenticated;
  String? get token => state.token;
  User? get user => state.user;
}
