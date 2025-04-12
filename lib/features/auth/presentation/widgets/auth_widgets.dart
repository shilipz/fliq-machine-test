import 'package:fliq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

Widget buildButton(
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
        Image.asset(icon, height: 20),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppTextStyles.nextButtonText.copyWith(color: textColor),
        ),
      ],
    ),
  );
}
