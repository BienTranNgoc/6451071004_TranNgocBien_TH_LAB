import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthResponseEntity> call({
    required String email,
    required String password,
    required String fullName,
  }) {
    return repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
