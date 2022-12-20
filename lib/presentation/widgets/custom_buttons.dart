import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(),
        onPressed: onPressed,
        child: const Text("Validate"));
  }
}
