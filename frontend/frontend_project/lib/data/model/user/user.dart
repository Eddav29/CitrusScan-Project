class User {
  final String userId;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? profilePicture;
  final String createdAt;
  final String updatedAt;
  final String password; // Menambahkan field password

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    required this.password,
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
      password: json['password'] ?? '',
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
      'password': password,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Menambahkan method copyWith
  User copyWith({
    String? userId,
    String? name,
    String? email,
    String? emailVerifiedAt,
    String? profilePicture,
    String? password,
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      profilePicture: profilePicture ?? this.profilePicture,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
