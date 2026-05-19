import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

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
              Text(AppStrings.successTitle, style: AppStyles.heading1),
              const SizedBox(height: 10),
              Text(
                AppStrings.successDesc,
                style: AppStyles.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SvgPicture.string(AppAssets.successSvg, height: 150),
              const SizedBox(height: 40),
              CustomButton(
                text: AppStrings.continueBtn,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: AppStrings.backToLogin,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
