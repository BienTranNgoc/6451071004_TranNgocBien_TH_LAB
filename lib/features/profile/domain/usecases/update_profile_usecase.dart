import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

/// Cập nhật một hồ sơ đã có (Update).
class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<int> call(ProfileEntity profile) {
    return repository.updateProfile(profile);
  }
}
