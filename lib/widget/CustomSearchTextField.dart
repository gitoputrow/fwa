import 'package:flutter/material.dart';

import '../values/Colors.dart';
import 'CustomButton.dart';

class CustomSearchTextField extends StatelessWidget {
  final void Function() ontap;
  final TextEditingController textEditingController;
  final String hintText;
  const CustomSearchTextField(
      {super.key,
      required this.ontap,
      required this.textEditingController,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
            color: blackcolor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primarycolor.withOpacity(0.5), width: 1)),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textEditingController,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText, 
                  hintStyle: TextStyle(color: greycolor, fontWeight: FontWeight.w500, fontSize: 16,),
                  contentPadding: EdgeInsets.zero,
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Color.fromARGB(0, 0, 0, 0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Color.fromARGB(0, 0, 0, 0))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Color.fromARGB(0, 0, 0, 0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Color.fromARGB(0, 0, 0, 0))),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            CustomButton(
                color: primarycolor,
                onPress: ontap,
                text: Text(
                  "Search",
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 15, color: darkcolor, fontWeight: FontWeight.w700),
                ))
          ],
        ),
      ),
    );
  }
}
