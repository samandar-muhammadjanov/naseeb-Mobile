// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:naseeb/utils/colors.dart';

class WTextField extends StatelessWidget {
  const WTextField(
      {super.key,
      required this.title,
      this.validator,
      this.onTap,
      this.hintText,
      this.suffix,
      this.maxLines,
      this.controller,
      this.onEditingComplete,
      this.onFieldSubmitted});
  final String title;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? hintText;
  final Widget? suffix;
  final int? maxLines;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: kgreyColor, fontFamily: "sfPro"),
        ),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: controller,
          maxLines: maxLines,
          onTap: onTap,
          validator: validator,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: kgreyColor,
              ),
            ),
            fillColor: fieldFocusColor,
          ),
        ),
      ],
    );
  }
}
