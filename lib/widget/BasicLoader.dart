import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:iconly/iconly.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BasicLoader extends StatelessWidget {
  const BasicLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlowingProgressIndicator(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Please Wait...",
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: primarycolor),
        )
      ],
    ));
  }
}
