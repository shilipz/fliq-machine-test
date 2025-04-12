import 'package:fliq/core/utils/responsive.dart';
import 'package:fliq/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fliq/core/theme/app_colors.dart';
import 'package:fliq/core/theme/app_text_styles.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_bg.png', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              children: [
                SizedBox(height: responsive.heightPercentage(10)),
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.favorite, color: AppColors.pink, size: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Connect. Meet. Love.\nWith Fliq Dating',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title,
                ),
                const Spacer(),
                buildButton(
                  context,
                  icon: 'assets/icons/google.png',
                  text: 'Sign in with Google',
                  onTap: () {},
                  color: AppColors.white,
                  textColor: AppColors.black,
                ),
                const SizedBox(height: 12),
                buildButton(
                  context,
                  icon: 'assets/icons/facebook.png',
                  text: 'Sign in with Facebook',
                  onTap: () {},
                  color: AppColors.facebookBlue,
                  textColor: AppColors.white,
                ),
                const SizedBox(height: 12),
                buildButton(
                  context,
                  icon: 'assets/icons/phone.png',
                  text: 'Sign in with phone number',
                  onTap: () {
                    Get.toNamed('/phone');
                  },
                  color: AppColors.pink,
                  textColor: AppColors.white,
                ),
                SizedBox(height: responsive.heightPercentage(3)),
                Text.rich(
                  TextSpan(
                    text: 'By signing in, you agree to our ',
                    style: AppTextStyles.terms,
                    children: [
                      TextSpan(text: 'Terms.', style: AppTextStyles.termsBold),
                      const TextSpan(text: ' See how we use your data in our '),
                      TextSpan(
                          text: 'Privacy Policy.',
                          style: AppTextStyles.termsBold),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
