/// Hợp đồng (abstract) cho nguồn dữ liệu cục bộ của Hồ sơ.
///
/// Làm việc với cấu trúc `Map` thuần để tách biệt khỏi domain.
abstract class ProfileLocalDataSource {
  Future<List<Map<String, dynamic>>> getProfiles();

  Future<Map<String, dynamic>?> getProfileById(int id);

  Future<int> insertProfile(Map<String, dynamic> row);

  Future<int> updateProfile(Map<String, dynamic> row);

  Future<int> deleteProfile(int id);
}
