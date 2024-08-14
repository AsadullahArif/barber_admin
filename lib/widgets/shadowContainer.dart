// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ShadowContainer({super.key, this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 380,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 250, 207, 142),
              Color(0xFFFFCC80),
              Color(0xFFFFB74D),
              Color(0xFFFFA726),
              Color(0xFFFF9800),
              Color(0xFFFB8C00),
              Color(0xFFEF6C00),
              Color(0xFFE65100),

            ]),
        color: color, // Orange color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: child, // Child widget
    );
  }
}
