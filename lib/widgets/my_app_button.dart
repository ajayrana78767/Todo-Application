import 'package:flutter/material.dart';

class MyAppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const MyAppButton({super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
