import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../values/Colors.dart';

class CustomRadioButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool isActive;

  const CustomRadioButton({super.key, required this.onTap, required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isActive ? BoxDecoration(borderRadius: BorderRadius.circular(15), color: greycolor) : null,
        child: Text(
          text,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isActive == true ? Colors.white : Color.fromARGB(255, 100, 100, 100)),
        ),
      ),
    );
  }
}
