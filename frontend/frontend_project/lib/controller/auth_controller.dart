import 'dart:convert';
import 'package:citrus_scan/data/model/user/auth_state.dart';
import 'package:citrus_scan/data/model/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/datasource/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthApi _authApi;
  final SharedPreferences _prefs;

  AuthController(this._authApi, this._prefs) : super(AuthState()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    try {
      final userJson = _prefs.getString('user');
      final token = _prefs.getString('token');

      if (userJson != null && token != null) {
        final user = User.fromJson(jsonDecode(userJson));
        state = state.copyWith(
          user: user,
          token: token,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
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

    if (response['status'] == 'error') {
      throw Exception('Email atau password salah.');
    }

    final user = User.fromJson(response['user']);
    final token = response['access_token'];

    await _prefs.setString('token', token);
    await _prefs.setString('user', jsonEncode(user.toJson()));

    state = state.copyWith(
      user: user,
      token: token,
      isLoading: false,
      error: null,
    );
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
    throw e; // Re-throw the error to handle it in the UI
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

    // Pastikan response memiliki data user
    if (response['user'] == null || response['access_token'] == null) {
      throw Exception('Gagal menyimpan akun ke database');
    }

    final user = User.fromJson(response['user']);
    final token = response['access_token'];

    await _prefs.setString('token', token);
    await _prefs.setString('user', jsonEncode(user.toJson()));

    state = state.copyWith(
      user: user,
      token: token,
      isLoading: false,
      error: null,
    );
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
    throw Exception(e); // Lempar error agar dapat ditangkap di UI
  }
}


  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authApi.logout();
      await _prefs.remove('token');
      await _prefs.remove('user');
      state = AuthState();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateProfile({String? name, String? email}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final response = await _authApi.updateProfile(name: name, email: email);
      final updatedUser = User.fromJson(response);
      await _prefs.setString('user', jsonEncode(updatedUser.toJson()));
      state = state.copyWith(
        user: updatedUser,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authApi.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordConfirmation: passwordConfirmation,
      );
      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
