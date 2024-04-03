import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedFunction;

  CustomButton({required this.buttonText, required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressedFunction(),
      child: Text(buttonText, style: TextStyle(fontSize: 16)),
    );
  }
}
