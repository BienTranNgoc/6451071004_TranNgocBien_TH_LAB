import '../entities/user_entity.dart';
import '../entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<AuthResponseEntity> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<AuthResponseEntity> login({
    required String email,
    required String password,
  });

  Future<AuthResponseEntity> resetPassword({required String email});

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();

  Stream<UserEntity?> authStateChanges();
}
