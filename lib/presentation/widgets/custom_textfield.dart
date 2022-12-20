import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.title,
      this.onChanged,
      this.obscureText = false,
      this.isMultiline = false});
  final String title;
  final Function(String)? onChanged;
  final bool? obscureText;
  final bool? isMultiline;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      obscureText: obscureText!,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: Text(title),
        hintText: title,
        hintStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
}
