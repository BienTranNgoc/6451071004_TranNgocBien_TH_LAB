import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';


class ServiceLocator {
  static void setup() {
    // Firebase
    final firebaseAuth = FirebaseAuth.instance;

    // Data Sources
    final authRemoteDataSource = FirebaseAuthDataSourceImpl(firebaseAuth);

    // Repositories
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);

    // UseCases
    final signUpUseCase = SignUpUseCase(authRepository);
    final loginUseCase = LoginUseCase(authRepository);
    final resetPasswordUseCase = ResetPasswordUseCase(authRepository);
    final logoutUseCase = LogoutUseCase(authRepository);
    final getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);

    // Providers
    authProviderInstance = AuthProvider(
      signUpUseCase: signUpUseCase,
      loginUseCase: loginUseCase,
      resetPasswordUseCase: resetPasswordUseCase,
      logoutUseCase: logoutUseCase,
      getCurrentUserUseCase: getCurrentUserUseCase,
    );
  }

  static late AuthProvider authProviderInstance;
}
