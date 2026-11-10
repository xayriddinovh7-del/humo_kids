class UserModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? avatarUrl;
  final String role; // 'parent', 'teacher', 'admin'
  final bool hasPin;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.avatarUrl,
    this.role = 'parent',
    this.hasPin = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String? ?? 'parent',
      hasPin: json['has_pin'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'avatar_url': avatarUrl,
        'role': role,
        'has_pin': hasPin,
      };
}

class AuthTokenModel {
  final String accessToken;
  final String? refreshToken;
  final String tokenType;
  final UserModel? user;

  const AuthTokenModel({
    required this.accessToken,
    this.refreshToken,
    this.tokenType = 'bearer',
    this.user,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['access_token'] as String? ?? json['token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

