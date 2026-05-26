import 'package:flutter/material.dart';
import '../views/splash/splash_screen.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/auth/check_email_screen.dart';
import '../views/auth/success_screen.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String checkEmail = '/check_email';
  static const String success = '/success';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => OnboardingScreen(),
        login: (context) => const LoginPage(),
        register: (context) => const RegisterPage(),
        forgotPassword: (context) => const ForgotPasswordPage(),
        checkEmail: (context) => const CheckEmailScreen(),
        success: (context) => const SuccessScreen(),
      };
}
