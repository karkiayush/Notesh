import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextEditingController controller;
  final String hintText;

  const FormWidget({
    super.key,
    this.maxLines,
    this.fontSize,
    required this.controller,
    required this.hintText, this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: TextStyle(fontSize: fontSize),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
