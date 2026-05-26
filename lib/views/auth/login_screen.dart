import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/social_button.dart';
import '../../widgets/custom_checkbox.dart';
import '../../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context, AuthController authController) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email và mật khẩu')),
      );
      return;
    }

    final success = await authController.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      authController.setRememberMe(_rememberMe);
      Navigator.pushReplacementNamed(context, '/');
    } else if (authController.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authController.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<AuthController>(
        builder: (context, authController, _) {
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
                          style: AppStyles.body2.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: authController.isLoading ? 'Đang đăng nhập...' : AppStrings.login,
                    onPressed: authController.isLoading
                        ? () {}
                        : () => _handleLogin(context, authController),
                  ),
                  const SizedBox(height: 20),
                  SocialButton(
                    text: AppStrings.signInGoogle,
                    onPressed: () {},
                  ),
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
