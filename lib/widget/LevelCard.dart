import 'package:flutter/material.dart';

import '../model/UserData.dart';
import '../values/Colors.dart';

class LevelCard extends StatelessWidget {
  final ChallangeData challangeData;
  const LevelCard(
      {super.key, required this.challangeData,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(color: blackcolor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            "${challangeData.title} Exercise",
            style: TextStyle(color: primarycolor, fontSize: 20),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Level Completed",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    challangeData.easy.toString(),
                    style:
                        TextStyle(color: primarycolor, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Easy",
                    style:
                        TextStyle(color: primarycolor, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                child: VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Column(
                children: [
                  Text(
                    challangeData.hard.toString(),
                    style:
                        TextStyle(color: primarycolor, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hard",
                    style:
                        TextStyle(color: primarycolor, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
