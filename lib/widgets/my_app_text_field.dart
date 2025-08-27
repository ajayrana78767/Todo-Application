import 'package:flutter/material.dart';

class MyAppTextField extends StatelessWidget {
  final String label;
  const MyAppTextField({super.key,required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 16,),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
