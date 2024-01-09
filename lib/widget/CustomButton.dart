import 'package:flutter/material.dart';
import 'package:free_workout_apps/values/Colors.dart';

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

class CustomButtonMenu extends StatelessWidget {
  final void Function() onTap;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icons;
  final String text;
  final Color textColor;
  const CustomButtonMenu({Key? key, required this.onTap, this.backgroundColor = blackcolor, this.iconColor = primarycolor, required this.icons, required this.text, this.textColor = primarycolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              icons,
              color: iconColor,
              size: 24,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              textScaleFactor: 1,
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
