// lib/controller/auth_controller.dart
import 'dart:convert';

import 'package:citrus_scan/data/model/auth_state.dart';
import 'package:citrus_scan/data/model/user.dart';
import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citrus_scan/data/datasource/auth_api.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthApi _authApi;
  final SharedPreferences _prefs;

  AuthController(this._authApi, this._prefs) : super(AuthState()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final token = _prefs.getString('token');
    final userData = _prefs.getString('user');

    if (token != null && userData != null) {
      try {
        final user = User.fromJson(jsonDecode(userData));
        state = state.copyWith(
          token: token,
          user: user,
        );
      } catch (e) {
        await _prefs.remove('token');
        await _prefs.remove('user');
      }
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

      // Generate a remember_token (could be any unique string or random token generator)
      final rememberToken = _generateRememberToken();

      // Ensure the email_verified_at is set to the current date if null
      final emailVerifiedAt = DateTime.now().toIso8601String();

      // API registration call
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

      // Save token and user data to SharedPreferences
      await _prefs.setString('token', token);
      await _prefs.setString('user', jsonEncode(user.toJson()));

      // Update state with the newly registered user and token
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
    // Here you can use any method to generate a unique token,
    // for example, generating a random string.
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

// Example token generation (you can replace this with your actual implementation)
  String generateToken() {
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

      await _prefs.setString('token', token);
      await _prefs.setString('user', jsonEncode(user.toJson()));

      state = state.copyWith(
        isLoading: false,
        user: user,
        token: token,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      if (state.token != null) {
        await _authApi.logout(token: state.token!);
      }

      await _prefs.remove('token');
      await _prefs.remove('user');

      state = AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  bool get isAuthenticated => state.isAuthenticated;
  String? get token => state.token;
  User? get user => state.user;
}
