/// Thực thể Hồ sơ cá nhân (Domain layer).
///
/// Là đối tượng Dart thuần, không phụ thuộc vào SQLite hay UI.
class ProfileEntity {
  final int? id;
  final String fullName;
  final String studentId;
  final String email;
  final String phone;
  final String address;

  ProfileEntity({
    this.id,
    required this.fullName,
    required this.studentId,
    required this.email,
    required this.phone,
    required this.address,
  });

  ProfileEntity copyWith({
    int? id,
    String? fullName,
    String? studentId,
    String? email,
    String? phone,
    String? address,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
