import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final DateTime? createAt;
  final bool emailVerfied;
  const UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.createAt,
    required this.emailVerfied,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      emailVerfied: json['emailVerfied'] as bool? ?? false,
      createAt:
          json['createAt'] != null
              ? DateTime.tryParse(json['createAt'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'createAt': createAt?.toIso8601String(),
      'emailVerfied': emailVerfied,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    DateTime? createAt,
    bool? emailVerfied,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      createAt: createAt ?? this.createAt,
      emailVerfied: emailVerfied ?? this.emailVerfied,
    );
  }

  @override
  List<Object?> get props => [id, name, email, role, createAt];
}
