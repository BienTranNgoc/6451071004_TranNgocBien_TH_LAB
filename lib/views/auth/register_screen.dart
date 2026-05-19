import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/social_button.dart';
import '../../widgets/custom_checkbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
              const CustomTextField(label: AppStrings.fullName),
              const SizedBox(height: 20),
              const CustomTextField(label: AppStrings.email),
              const SizedBox(height: 20),
              const CustomTextField(label: AppStrings.password, isPassword: true),
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
                text: AppStrings.btnSignUp,
                onPressed: () {},
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
      ),
    );
  }
}
