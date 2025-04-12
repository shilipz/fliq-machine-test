import 'package:fliq/core/theme/app_colors.dart';
import 'package:fliq/core/theme/app_text_styles.dart';
import 'package:fliq/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildReceiverBubble(String text, String time) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          ),
        ),
        Text(
          formatTime(time),
          style: AppTextStyles.sentAtText,
        )
      ],
    ),
  );
}

///////////////////////////

Widget buildSenderBubble(String text, String time) {
  return Align(
    alignment: Alignment.centerRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 75, 126),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              formatTime(time),
              style: AppTextStyles.sentAtText,
            ),
            Icon(
              Icons.done_all,
              color: AppColors.greyText,
              size: 10,
            )
          ],
        )
      ],
    ),
  );
}
