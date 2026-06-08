import '../entities/profile_entity.dart';

/// Hợp đồng (abstract) cho tầng dữ liệu của tính năng Hồ sơ.
///
/// Tầng domain chỉ phụ thuộc vào abstraction này, không biết
/// dữ liệu đến từ SQLite hay nguồn nào khác (Dependency Inversion).
abstract class ProfileRepository {
  Future<List<ProfileEntity>> getProfiles();

  Future<ProfileEntity?> getProfileById(int id);

  Future<int> createProfile(ProfileEntity profile);

  Future<int> updateProfile(ProfileEntity profile);

  Future<int> deleteProfile(int id);
}
