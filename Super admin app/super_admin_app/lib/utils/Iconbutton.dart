import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final Function() onPressed;

  const IconButtonCustom({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => onPressed()));
      },
      icon: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}


