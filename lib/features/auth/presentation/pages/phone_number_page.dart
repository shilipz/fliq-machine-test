import 'package:fliq/core/theme/app_colors.dart';
import 'package:fliq/core/theme/app_text_styles.dart';
import 'package:fliq/core/utils/responsive.dart';
import 'package:fliq/core/widgets/common_widgets.dart';
import 'package:fliq/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final responsive = Responsive(context);
    String fullPhoneNumber = '';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.widthPercentage(6),
            vertical: responsive.heightPercentage(1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomArrowBack(),
              SizedBox(height: responsive.heightPercentage(2.5)), // 20px
              Center(
                child: Text(
                  'Enter your phone number',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading28.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(height: responsive.heightPercentage(3.5)), // 30px
              IntlPhoneField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.lightGrey),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  fullPhoneNumber = phone.completeNumber;
                },
                onCountryChanged: (country) {
                  fullPhoneNumber = country.dialCode;
                },
              ),
              Text(
                'Fliq will send you a text with a verification code.',
                style: AppTextStyles.bodyText.copyWith(
                  color: AppColors.darkGrey,
                ),
              ),
              const Spacer(),
              Obx(() {
                return authController.isLoading.value
                    ? Center(
                        child: LinearProgressIndicator(
                        color: AppColors.white,
                      ))
                    : GestureDetector(
                        onTap: () {
                          if (fullPhoneNumber.isNotEmpty) {
                            authController.phoneNumber.value = fullPhoneNumber;
                            authController.sendOtp();
                          } else {
                            Get.snackbar(
                                'Error', 'Please enter a valid phone number');
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: responsive.heightPercentage(2),
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF857A6), Color(0xFFFF5858)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              style: AppTextStyles.buttonText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      );
              }),
              SizedBox(height: responsive.heightPercentage(3)),
            ],
          ),
        ),
      ),
    );
  }
}
