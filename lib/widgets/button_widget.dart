import 'package:flutter/material.dart';
import 'package:notesh/theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final IconData buttonIcon;
  final VoidCallback? onTap;
  final Color? iconColor;

  const ButtonWidget(
      {super.key, required this.buttonIcon, this.onTap, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: buttonContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            buttonIcon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
