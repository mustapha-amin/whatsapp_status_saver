import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/textstyle.dart';

void displaySnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: kTextStyle(13, color: Colors.white),
      ),
      margin: const EdgeInsets.all(5),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    ),
  );
}
