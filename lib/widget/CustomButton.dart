import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final Color color;
  final Color borderColor;
  final Function() onPress;
  final double borderRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  const CustomButton({
    Key? key,
    this.borderRadius = 10.0,
    required this.color,
    this.borderColor = Colors.transparent,
    this.splashFactory = null,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        splashFactory: splashFactory,
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: text,
    );
  }
}
