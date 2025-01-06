import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String name;
  final Function() onPressed;
  const Button({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(230, 45),
        backgroundColor: const Color(0xff407BFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
       onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => onPressed()));
      },
      child: Text(
        name,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}