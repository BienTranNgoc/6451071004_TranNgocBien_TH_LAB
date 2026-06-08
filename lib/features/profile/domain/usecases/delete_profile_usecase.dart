import '../repositories/profile_repository.dart';

/// Xoá một hồ sơ theo id (Delete).
class DeleteProfileUseCase {
  final ProfileRepository repository;

  DeleteProfileUseCase(this.repository);

  Future<int> call(int id) {
    return repository.deleteProfile(id);
  }
}
