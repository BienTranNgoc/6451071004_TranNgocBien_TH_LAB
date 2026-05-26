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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _rememberMe = false;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp(BuildContext context, AuthProvider authProvider) async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền tất cả các trường')),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu phải có ít nhất 6 ký tự')),
      );
      return;
    }

    final success = await authProvider.signUp(
      email: emailController.text.trim(),
      password: passwordController.text,
      fullName: fullNameController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, '/success');
    } else if (authProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage!)),
      );
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
                  const SizedBox(height: 20),
                  Text(AppStrings.createAccount, style: AppStyles.heading1),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.loginDesc,
                    style: AppStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    label: AppStrings.fullName,
                    controller: fullNameController,
                  ),
                  const SizedBox(height: 20),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: authProvider.isLoading ? 'Đang đăng ký...' : AppStrings.btnSignUp,
                    onPressed: authProvider.isLoading
                        ? () {}
                        : () => _handleSignUp(context, authProvider),
                  ),
                  const SizedBox(height: 20),
                  SocialButton(
                    text: AppStrings.signUpGoogle,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.alreadyHaveAccount, style: AppStyles.body2),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.signIn,
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
