import 'user_entity.dart';

class AuthResponseEntity {
  final bool success;
  final String? message;
  final UserEntity? user;

  AuthResponseEntity({required this.success, this.message, this.user});
}
