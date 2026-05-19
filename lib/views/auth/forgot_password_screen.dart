import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              const SizedBox(height: 40),
              Text(AppStrings.forgotPassTitle, style: AppStyles.heading1),
              const SizedBox(height: 10),
              Text(
                AppStrings.forgotPassDesc,
                style: AppStyles.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SvgPicture.string(AppAssets.forgotPasswordSvg, height: 150),
              const SizedBox(height: 40),
              const CustomTextField(label: AppStrings.email),
              const SizedBox(height: 30),
              CustomButton(
                text: AppStrings.resetPassword,
                onPressed: () {
                  Navigator.pushNamed(context, '/check_email');
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: AppStrings.backToLogin,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: AppColors.secondary,
                textColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
