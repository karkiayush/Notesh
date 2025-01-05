import 'package:flutter/material.dart';
import 'package:notesh/theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final IconData buttonIcon;
  final VoidCallback? onTap;

  const ButtonWidget({super.key, required this.buttonIcon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(buttonIcon),
        ),
      ),
    );
  }
}
