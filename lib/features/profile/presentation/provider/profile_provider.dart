import 'package:flutter/material.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profiles_usecase.dart';
import '../../domain/usecases/create_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/delete_profile_usecase.dart';

/// State management cho tính năng Hồ sơ (Provider).
class ProfileProvider extends ChangeNotifier {
  final GetProfilesUseCase getProfilesUseCase;
  final CreateProfileUseCase createProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfileUseCase deleteProfileUseCase;

  ProfileProvider({
    required this.getProfilesUseCase,
    required this.createProfileUseCase,
    required this.updateProfileUseCase,
    required this.deleteProfileUseCase,
  });

  List<ProfileEntity> _profiles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProfileEntity> get profiles => _profiles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Đọc danh sách hồ sơ từ SQLite (Read).
  Future<void> loadProfiles() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _profiles = await getProfilesUseCase();
    } catch (e) {
      _errorMessage = 'Không thể tải danh sách hồ sơ: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Thêm mới hồ sơ (Create) rồi tải lại danh sách.
  Future<bool> addProfile(ProfileEntity profile) async {
    try {
      await createProfileUseCase(profile);
      await loadProfiles();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi khi thêm hồ sơ: $e';
      notifyListeners();
      return false;
    }
  }

  /// Cập nhật hồ sơ (Update) rồi tải lại danh sách.
  Future<bool> editProfile(ProfileEntity profile) async {
    try {
      await updateProfileUseCase(profile);
      await loadProfiles();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi khi cập nhật hồ sơ: $e';
      notifyListeners();
      return false;
    }
  }

  /// Xoá hồ sơ theo id (Delete) rồi tải lại danh sách.
  Future<bool> removeProfile(int id) async {
    try {
      await deleteProfileUseCase(id);
      await loadProfiles();
      return true;
    } catch (e) {
      _errorMessage = 'Lỗi khi xoá hồ sơ: $e';
      notifyListeners();
      return false;
    }
  }
}
