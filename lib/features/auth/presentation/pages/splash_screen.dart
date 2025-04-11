import 'package:fliq/features/auth/presentation/pages/phone_number_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.3), // optional overlay
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              children: [
                SizedBox(height: 80),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.pink, size: 30),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Connect. Meet. Love.\nWith Fliq Dating',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Spacer(),
                _buildButton(
                  context,
                  icon: 'assets/icons/google.png',
                  text: 'Sign in with Google',
                  onTap: () {},
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 12),

                _buildButton(
                  context,
                  icon: 'assets/icons/facebook.png',
                  text: 'Sign in with Facebook',
                  onTap: () {},
                  color: Color(0xFF3b5998),
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),

                _buildButton(
                  context,
                  icon: 'assets/icons/facebook.png',
                  text: 'Sign in with phone number',
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PhoneNumberScreen();
                    }));
                  },
                  color: Colors.pink,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20),

                Text.rich(
                  TextSpan(
                    text: 'By signing in, you agree to our ',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Terms.',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                      const TextSpan(
                        text: 'See how we use your data in our ',
                        style:
                             TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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

  Widget _buildButton(
    BuildContext context, {
    required String icon,
    required String text,
    required VoidCallback onTap,
    required Color color,
    required Color textColor,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 24),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
