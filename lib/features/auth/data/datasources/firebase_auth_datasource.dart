import 'package:firebase_auth/firebase_auth.dart';
import 'auth_remote_datasource.dart';

class FirebaseAuthDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(fullName);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e.code);
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e.code);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e.code);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Lỗi đăng xuất: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _userToMap(user);
  }

  @override
  Stream<Map<String, dynamic>?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return _userToMap(user);
    });
  }

  Map<String, dynamic> _userToMap(User user) {
    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
      'emailVerified': user.emailVerified,
    };
  }

  Exception _handleAuthException(String code) {
    switch (code) {
      case 'weak-password':
        return Exception('Mật khẩu quá yếu (tối thiểu 6 ký tự)');
      case 'email-already-in-use':
        return Exception('Email đã được sử dụng');
      case 'user-not-found':
        return Exception('Người dùng không tồn tại');
      case 'wrong-password':
        return Exception('Mật khẩu không chính xác');
      case 'invalid-email':
        return Exception('Email không hợp lệ');
      case 'too-many-requests':
        return Exception('Quá nhiều lần đăng nhập thất bại. Vui lòng thử lại sau');
      case 'network-request-failed':
        return Exception('Lỗi kết nối mạng');
      default:
        return Exception('Lỗi: $code');
    }
  }
}
