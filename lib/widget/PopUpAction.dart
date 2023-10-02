import 'package:flutter/material.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:iconly/iconly.dart';

import 'CustomButton.dart';

class PopUpAction extends StatelessWidget {
  final String text;
  final String textBtn1;
  final String textBtn2;
  final Color borderColor;
  final void Function() onPressAction1;
  final void Function() onPressAction2;
  const PopUpAction(
      {Key? key,
      required this.text,
      required this.textBtn1,
      required this.textBtn2,
      this.borderColor = const Color.fromARGB(0, 0, 0, 0),
      required this.onPressAction1,
      required this.onPressAction2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: blackcolor,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        // side: BorderSide(color: primarycolor,width: 0.5)
      ),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        padding: const EdgeInsets.only(right: 28, left: 28, top: 12, bottom: 28),
        decoration: BoxDecoration(border: Border.all(color: borderColor, width: 1),borderRadius: BorderRadius.circular(15),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  height: 1.5,
                  color: primarycolor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                    color: primarycolor,
                    onPress: onPressAction1,
                    text: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        textBtn1,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    color: blackcolor,
                    borderColor: primarycolor,
                    onPress: onPressAction2,
                    text: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        textBtn2,
                        style: TextStyle(
                            color: primarycolor, fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
