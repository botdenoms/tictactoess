import 'package:flutter/material.dart';

class HelperText extends StatelessWidget {
  const HelperText({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF4F4242),
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Imprima',
            color: Color(0xFFFFFFFF),
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
