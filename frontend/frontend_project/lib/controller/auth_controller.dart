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
      
      final response = await _authApi.register(
        email: email,
        password: password,
        name: name,
        passwordConfirmation: passwordConfirmation,
      );
      
      final user = User.fromJson(response);
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
      
      final user = User.fromJson(response);
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