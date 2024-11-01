class User {
  final String userId;
  final String name;
  final String email;
  final String? accessToken;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user']['user_id'],
      name: json['user']['name'],
      email: json['user']['email'],
      accessToken: json['access_token'],  // Mengambil access token dari respons
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'access_token': accessToken,
    };
  }
}
