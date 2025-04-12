import 'package:fliq/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final title = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final terms = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.white,
  );

  static final termsBold = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
  );
  static final heading28 = GoogleFonts.jost(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static final buttonText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final bodyText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final sentAtText =
      GoogleFonts.poppins(fontSize: 10, color: AppColors.greyText);

  static final nextButtonText = GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
