import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const Button({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Color.fromARGB(255, 9, 1, 64),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
