import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

/// Lấy toàn bộ danh sách hồ sơ (Read).
class GetProfilesUseCase {
  final ProfileRepository repository;

  GetProfilesUseCase(this.repository);

  Future<List<ProfileEntity>> call() {
    return repository.getProfiles();
  }
}
