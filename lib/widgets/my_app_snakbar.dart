import 'package:flutter/material.dart';

class MyAppSnakbar {
  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
