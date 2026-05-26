import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    bool emailVerified = false,
  }) : super(
    uid: uid,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    emailVerified: emailVerified,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
    };
  }
}
