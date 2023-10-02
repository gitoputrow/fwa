import 'package:flutter/material.dart';

import '../values/Colors.dart';

class CustomBottomSheetPic extends StatelessWidget {
  final void Function() ontapCamera;
  final void Function() ontapPicture;
  const CustomBottomSheetPic({super.key, required this.ontapCamera, required this.ontapPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: blackcolor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            height: 6,
            width: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(color: greycolor, borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: ontapCamera,
                color: blackcolor,
                textColor: primarycolor,
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 30,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(side: BorderSide(color: primarycolor,width: 1)),
              ),
              SizedBox(
                width: 28,
              ),
              MaterialButton(
                onPressed: ontapPicture,
                color: blackcolor,
                textColor: primarycolor,
                child: Icon(
                  Icons.image_rounded,
                  size: 30,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(side: BorderSide(color: primarycolor,width: 1)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
