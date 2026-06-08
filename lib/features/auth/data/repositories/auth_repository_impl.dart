import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthResponseEntity> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );

      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return AuthResponseEntity(
          success: true,
          user: UserModel.fromJson(user),
        );
      }
      return AuthResponseEntity(success: true);
    } catch (e) {
      return AuthResponseEntity(success: false, message: e.toString());
    }
  }

  @override
  Future<AuthResponseEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      await remoteDataSource.login(email: email, password: password);

      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return AuthResponseEntity(
          success: true,
          user: UserModel.fromJson(user),
        );
      }
      return AuthResponseEntity(success: true);
    } catch (e) {
      return AuthResponseEntity(success: false, message: e.toString());
    }
  }

  @override
  Future<AuthResponseEntity> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      return AuthResponseEntity(
        success: true,
        message: 'Link reset mật khẩu đã được gửi tới $email',
      );
    } catch (e) {
      return AuthResponseEntity(success: false, message: e.toString());
    }
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return UserModel.fromJson(user);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return remoteDataSource.authStateChanges().map((userMap) {
      if (userMap == null) return null;
      return UserModel.fromJson(userMap);
    });
  }
}
