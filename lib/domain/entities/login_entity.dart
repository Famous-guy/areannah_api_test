// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginEntity {
  String status;
  String message;
  String accessToken;
  String refreshToken;
  String id;
  String name;
  String email;
  String? phone_number;
  String role;
  LoginEntity({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.email,
    this.phone_number,
    required this.role,
  });
}
