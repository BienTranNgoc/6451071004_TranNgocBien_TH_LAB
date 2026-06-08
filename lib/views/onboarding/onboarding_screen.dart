import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxHeight < 650;
            final minHeight = constraints.maxHeight > 40
                ? constraints.maxHeight - 40
                : 0.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('Jobspot', style: AppStyles.heading3),
                    ),
                    SizedBox(height: isCompact ? 24 : 40),
                    Center(
                      child: SvgPicture.string(
                        AppAssets.onboardingSvg,
                        height: isCompact ? 180 : 250,
                      ),
                    ),
                    SizedBox(height: isCompact ? 24 : 40),
                    RichText(
                      text: TextSpan(
                        style: AppStyles.heading1,
                        children: const [
                          TextSpan(text: 'Find Your\n'),
                          TextSpan(
                            text: 'Dream Job\n',
                            style: TextStyle(
                              color: AppColors.accent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: 'Here!'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(AppStrings.onboardingDesc, style: AppStyles.body1),
                    SizedBox(height: isCompact ? 28 : 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: AppColors.primary,
                            dotColor: AppColors.secondary,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          backgroundColor: AppColors.primary,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
