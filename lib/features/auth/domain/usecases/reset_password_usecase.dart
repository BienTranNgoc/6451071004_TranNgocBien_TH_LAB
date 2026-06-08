import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<AuthResponseEntity> call({required String email}) {
    return repository.resetPassword(email: email);
  }
}
