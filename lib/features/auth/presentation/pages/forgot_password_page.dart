import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:jobspot/utils/app_colors.dart';
import 'package:jobspot/utils/app_assets.dart';
import 'package:jobspot/utils/app_strings.dart';
import 'package:jobspot/utils/app_styles.dart';
import 'package:jobspot/widgets/custom_button.dart';
import 'package:jobspot/widgets/custom_textfield.dart';
import '../provider/auth_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword(AuthProvider authProvider) async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập email')));
      return;
    }

    final success = await authProvider.resetPassword(
      email: emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      setState(() {
        _emailSent = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushNamed(context, '/check_email');
        }
      });
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
                  CustomTextField(
                    label: AppStrings.email,
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: authProvider.isLoading
                        ? 'Đang gửi...'
                        : AppStrings.resetPassword,
                    onPressed: authProvider.isLoading
                        ? () {}
                        : () => _handleResetPassword(authProvider),
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
                  if (_emailSent)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Link reset mật khẩu đã được gửi tới ${emailController.text}',
                        style: AppStyles.body2.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
