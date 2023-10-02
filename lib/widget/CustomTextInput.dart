import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../values/Colors.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String title;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final EdgeInsets contentPadding;
  const CustomTextInput(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.textInputType,
      this.suffixIcon,
      this.obscureText = false,
      required this.title,
      this.onChanged, this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 24)});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: primarycolor.withOpacity(0.8)),
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          controller: textEditingController,
          keyboardType: textInputType,
          style: TextStyle(fontSize: 18, color: Colors.white),
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 18, color: greycolor),
            fillColor: blackcolor,
            filled: true,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: primarycolor.withOpacity(0.4), width: 1),
                borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primarycolor.withOpacity(0.4), width: 1),
                borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primarycolor.withOpacity(0.7), width: 1),
                borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
