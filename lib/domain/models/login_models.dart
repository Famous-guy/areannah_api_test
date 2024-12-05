// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../entities/login_entity.dart';

class LoginModels extends LoginEntity {
  String status;
  String message;
  String accessToken;
  String refreshToken;
  String id;
  String name;
  String email;
  String? phone_number;
  String role;
  LoginModels({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.email,
    this.phone_number,
    required this.role,
  }) : super(
          status: status,
          message: message,
          accessToken: accessToken,
          refreshToken: refreshToken,
          id: id,
          name: name,
          email: email,
          role: role,
          phone_number: phone_number,
        );

  LoginModels copyWith({
    String? status,
    String? message,
    String? accessToken,
    String? refreshToken,
    String? id,
    String? name,
    String? email,
    String? phone_number,
    String? role,
  }) {
    return LoginModels(
      status: status ?? this.status,
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone_number: phone_number ?? this.phone_number,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phone_number,
      'role': role,
    };
  }

  factory LoginModels.fromMap(Map<String, dynamic> map) {
    final data = map["data"] ?? {};
    final account = data['account'] ?? {};

    if (data.isEmpty || account.isEmpty) {
      throw Exception("Invalid data: Missing required fields");
    }

    return LoginModels(
      status: map['status'],
      message: map['message'],
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
      id: account['id'],
      name: account['name'],
      email: account['email'],
      phone_number: account['phone_number'],
      role: account['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModels.fromJson(String source) =>
      LoginModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginModels(status: $status, message: $message, accessToken: $accessToken, refreshToken: $refreshToken, id: $id, name: $name, email: $email, phone_number: $phone_number, role: $role)';
  }

  @override
  bool operator ==(covariant LoginModels other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone_number == phone_number &&
        other.role == role;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone_number.hashCode ^
        role.hashCode;
  }
}
