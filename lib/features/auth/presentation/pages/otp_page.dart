
import 'package:fliq/core/theme/app_colors.dart';
import 'package:fliq/core/utils/responsive.dart';
import 'package:fliq/core/widgets/common_widgets.dart';
import 'package:fliq/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phone;
  const OTPVerificationScreen({super.key, required this.phone});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String _otpCode = '';
  final String phone = Get.arguments['phone'] ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomArrowBack(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  textAlign: TextAlign.center,
                  'Enter your verification code',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: '${widget.phone}.',
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: ' Edit',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              OtpTextField(
                fieldWidth: Responsive(context).widthPercentage(12),
                numberOfFields: 6,
                borderColor: const Color(0xFF512DA8),
                focusedBorderColor: Colors.pink,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String code) {
                  setState(() {
                    _otpCode = code;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  text: "Didn't get anything? No worries, let's try again. ",
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: '\nResent',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.white,
                        )),
                      );

                      await AuthService.verifyOtp(
                        widget.phone,
                        _otpCode,
                      );

                      Get.back();

                      Get.offAllNamed('/messages');
                    } catch (e) {
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to verify OTP')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
