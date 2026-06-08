abstract class AuthRemoteDataSource {
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> login({required String email, required String password});

  Future<void> resetPassword({required String email});

  Future<void> logout();

  Future<Map<String, dynamic>?> getCurrentUser();

  Stream<Map<String, dynamic>?> authStateChanges();
}
