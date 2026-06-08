import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

/// Thêm mới một hồ sơ (Create).
class CreateProfileUseCase {
  final ProfileRepository repository;

  CreateProfileUseCase(this.repository);

  Future<int> call(ProfileEntity profile) {
    return repository.createProfile(profile);
  }
}
