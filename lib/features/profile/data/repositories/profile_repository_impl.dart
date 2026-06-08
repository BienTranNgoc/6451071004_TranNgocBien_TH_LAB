import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/profile_model.dart';

/// Triển khai [ProfileRepository]: chuyển đổi giữa Map (data) và Entity (domain).
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(this.localDataSource);

  @override
  Future<List<ProfileEntity>> getProfiles() async {
    final rows = await localDataSource.getProfiles();
    return rows.map((row) => ProfileModel.fromMap(row)).toList();
  }

  @override
  Future<ProfileEntity?> getProfileById(int id) async {
    final row = await localDataSource.getProfileById(id);
    if (row == null) return null;
    return ProfileModel.fromMap(row);
  }

  @override
  Future<int> createProfile(ProfileEntity profile) {
    return localDataSource.insertProfile(
      ProfileModel.fromEntity(profile).toMap(),
    );
  }

  @override
  Future<int> updateProfile(ProfileEntity profile) {
    return localDataSource.updateProfile(
      ProfileModel.fromEntity(profile).toMap(),
    );
  }

  @override
  Future<int> deleteProfile(int id) {
    return localDataSource.deleteProfile(id);
  }
}
