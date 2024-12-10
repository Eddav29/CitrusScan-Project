// lib/data/model/user.dart
class User {
  final String userId;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? profilePicture;
  final String createdAt;
  final String updatedAt;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      profilePicture: json['profile_picture'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'profile_picture': profilePicture,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
