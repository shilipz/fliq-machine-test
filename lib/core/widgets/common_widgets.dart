import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.10; 
    size =
        size.clamp(30.0, 40.0);

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



  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final msgDate = DateTime(date.year, date.month, date.day);

    if (msgDate == today) {
      return 'Today';
    } else if (msgDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${monthName(date.month)} ${date.day}';
    }
  }

  String monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }