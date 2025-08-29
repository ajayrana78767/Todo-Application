import 'package:flutter/material.dart';

class MyAppTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final int minLines;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyAppTextField({
    super.key,
    required this.label,
    this.hintText,
    required this.minLines,
    required this.maxLines,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hintText ?? 'Enter $label here...',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
