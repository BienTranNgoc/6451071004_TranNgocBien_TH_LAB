import 'package:flutter/material.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/entities/user_entity.dart';

class AuthProvider extends ChangeNotifier {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  UserEntity? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _rememberMe = false;

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;
  bool get rememberMe => _rememberMe;

  AuthProvider({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.resetPasswordUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) {
    _checkAuthState();
  }

  void _checkAuthState() {
    getCurrentUserUseCase().then((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await signUpUseCase(
        email: email,
        password: password,
        fullName: fullName,
      );

      if (response.success) {
        _user = response.user;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message ?? 'Đăng ký thất bại';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Lỗi: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await loginUseCase(email: email, password: password);

      if (response.success) {
        _user = response.user;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message ?? 'Đăng nhập thất bại';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Lỗi: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await resetPasswordUseCase(email: email);

      if (response.success) {
        _errorMessage = response.message;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message ?? 'Không thể reset mật khẩu';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Lỗi: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await logoutUseCase();
      _user = null;
      _errorMessage = null;
      _rememberMe = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Lỗi đăng xuất: $e';
      notifyListeners();
    }
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
