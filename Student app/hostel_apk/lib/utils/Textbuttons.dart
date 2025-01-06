import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  final String name;
  final Function() onPressed;
  const Textbutton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
       onPressed();
      },
      child: Text(
        name,
        style: const TextStyle(
            fontSize: 16,
            color: Color(0xff407BFF),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
