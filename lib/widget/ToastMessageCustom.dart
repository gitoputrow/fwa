import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:iconly/iconly.dart';

class ToastMessageCustom {
  static void ToastMessage(String text, Color color, context,{Color? borderColor =  null}) {
    Flushbar(
      duration: Duration(seconds: 3),
      backgroundColor: color,
      borderRadius: BorderRadius.circular(20),
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      borderColor: borderColor,

      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 15,
          ),
          Icon(
            Icons.warning,
            color: primarycolor,
            size: 33,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "RubikMedium",
                color: primarycolor,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    )..show(context);
  }
}
