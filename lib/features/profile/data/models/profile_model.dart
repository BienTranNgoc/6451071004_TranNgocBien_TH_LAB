import '../../../../core/db/app_database.dart';
import '../../domain/entities/profile_entity.dart';

/// Model tầng Data - mở rộng [ProfileEntity] và bổ sung chuyển đổi
/// sang/ từ `Map` của SQLite (toMap / fromMap).
class ProfileModel extends ProfileEntity {
  ProfileModel({
    super.id,
    required super.fullName,
    required super.studentId,
    required super.email,
    required super.phone,
    required super.address,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map[AppDatabase.colId] as int?,
      fullName: map[AppDatabase.colFullName] as String? ?? '',
      studentId: map[AppDatabase.colStudentId] as String? ?? '',
      email: map[AppDatabase.colEmail] as String? ?? '',
      phone: map[AppDatabase.colPhone] as String? ?? '',
      address: map[AppDatabase.colAddress] as String? ?? '',
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      fullName: entity.fullName,
      studentId: entity.studentId,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      AppDatabase.colFullName: fullName,
      AppDatabase.colStudentId: studentId,
      AppDatabase.colEmail: email,
      AppDatabase.colPhone: phone,
      AppDatabase.colAddress: address,
    };
    if (id != null) {
      map[AppDatabase.colId] = id;
    }
    return map;
  }
}
