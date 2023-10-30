import 'package:flutter/material.dart';
import 'package:habits_tracker/core/constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final Function() onTap;
  final Color? color;
  const PrimaryButton(
      {this.text, this.icon, required this.onTap, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? kAccentColor,
      ),
      onPressed: onTap,
      child: text != null
          ? Text(
              text!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : icon,
    );
  }
}
