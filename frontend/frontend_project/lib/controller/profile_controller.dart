import 'package:citrus_scan/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:citrus_scan/data/model/user/profile/profile_state.dart';
import 'package:citrus_scan/data/datasource/profile_api.dart';
import 'package:citrus_scan/data/model/user/user.dart';

class ProfileController extends StateNotifier<ProfileState> {
  final ProfileApi _profileApi;

  ProfileController(this._profileApi) : super(ProfileState());

  Future<void> getProfile(String token) async {
    try {
      state = state.copyWith(isLoading: true);
      final user = await _profileApi.getProfile(token);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateProfile(String token,
      {String? name, String? email}) async {
    try {
      state = state.copyWith(isLoading: true);
      final user =
          await _profileApi.updateProfile(token, name: name, email: email);
      state = state.copyWith(user: user, isLoading: false, isUpdated: true);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updatePassword(String token, String oldPassword, String newPassword) async {
    try {
      state = state.copyWith(isLoading: true);
      final user = await _profileApi.updatePassword(token, oldPassword, newPassword);
      state = state.copyWith(user: user, isLoading: false, isUpdated: true);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
  final profileApi = ref.watch(profileApiProvider);
  return ProfileController(profileApi);
});
