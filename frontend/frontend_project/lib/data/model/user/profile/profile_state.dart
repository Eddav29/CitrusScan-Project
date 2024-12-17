import 'package:citrus_scan/data/model/user/user.dart';

class ProfileState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isUpdated;

  ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isUpdated = false,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isUpdated,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
}
