import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobspot/utils/app_colors.dart';
import 'package:jobspot/utils/app_strings.dart';
import 'package:jobspot/utils/app_styles.dart';
import 'package:jobspot/widgets/custom_button.dart';
import 'package:jobspot/widgets/custom_textfield.dart';
import 'package:jobspot/widgets/social_button.dart';
import 'package:jobspot/widgets/custom_checkbox.dart';
import '../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(AuthProvider authProvider) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email và mật khẩu')),
      );
      return;
    }

    final success = await authProvider.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      authProvider.setRememberMe(_rememberMe);
      Navigator.pushReplacementNamed(context, '/home');
    } else if (authProvider.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(authProvider.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(AppStrings.welcomeBack, style: AppStyles.heading1),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.loginDesc,
                    style: AppStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    label: AppStrings.email,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: AppStrings.password,
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCheckbox(
                        value: _rememberMe,
                        label: AppStrings.rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppStyles.body2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: authProvider.isLoading
                        ? 'Đang đăng nhập...'
                        : AppStrings.login,
                    onPressed: authProvider.isLoading
                        ? () {}
                        : () => _handleLogin(authProvider),
                  ),
                  const SizedBox(height: 20),
                  SocialButton(text: AppStrings.signInGoogle, onPressed: () {}),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.dontHaveAccount, style: AppStyles.body2),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          AppStrings.signUp,
                          style: AppStyles.body2.copyWith(
                            color: AppColors.accent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
