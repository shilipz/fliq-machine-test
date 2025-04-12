import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.10; // Responsive size
    size =
        size.clamp(30.0, 40.0); // Prevent it from being too small or too large

    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        iconSize: size * 0.5, 
        padding: EdgeInsets.zero, 
        onPressed: () => Get.back(),
      ),
    );
  }
}

String capitalize(String input) {
  if (input.isEmpty) return '';
  return input[0].toUpperCase() + input.substring(1);
}

String formatTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  return DateFormat.jm().format(dateTime); 
}
