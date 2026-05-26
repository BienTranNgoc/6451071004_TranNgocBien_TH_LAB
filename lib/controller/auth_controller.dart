import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  bool isLoading = false;
  String? errorMessage;
  bool _rememberMe = false;

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get rememberMe => _rememberMe;

  AuthController() {
    checkAuthState();
  }

  // Register
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);
      _user = credential.user;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = 'Lỗi không xác định: $e';
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final credential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      _user = credential.user;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = 'Lỗi không xác định: $e';
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Forgot password
  Future<bool> resetPassword({
    required String email
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _auth.sendPasswordResetEmail(email: email);
      errorMessage = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _getErrorMessage(e.code);
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = 'Lỗi không xác định: $e';
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      _user = null;
      errorMessage = null;
      _rememberMe = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Lỗi đăng xuất: $e';
      notifyListeners();
    }
  }

  // Check login status
  void checkAuthState() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Mật khẩu quá yếu (tối thiểu 6 ký tự)';
      case 'email-already-in-use':
        return 'Email đã được sử dụng';
      case 'user-not-found':
        return 'Người dùng không tồn tại';
      case 'wrong-password':
        return 'Mật khẩu không chính xác';
      case 'invalid-email':
        return 'Email không hợp lệ';
      case 'too-many-requests':
        return 'Quá nhiều lần đăng nhập thất bại. Vui lòng thử lại sau';
      case 'network-request-failed':
        return 'Lỗi kết nối mạng';
      default:
        return 'Lỗi: $code';
    }
  }
}