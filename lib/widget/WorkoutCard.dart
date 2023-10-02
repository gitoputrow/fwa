import 'package:flutter/material.dart';
import 'package:free_workout_apps/model/WorkoutProgram.dart';

import '../values/Colors.dart';
import 'CustomButton.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutProgram workoutProgram;
  final void Function() onpressed;
  const WorkoutCard({super.key, required this.workoutProgram, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 20 / 9, // Menentukan proporsi tinggi terhadap lebar (contoh 16:9).
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: greycolor, width: 2),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/${workoutProgram.name!.toLowerCase().replaceAll(" ", "")}pic.png",
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 0),
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workoutProgram.name!,
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500, color: primarycolor),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Exercise",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  Spacer(),
                  CustomButton(
                    color: primarycolor,
                    borderRadius: 20,
                    onPress: onpressed,
                    text: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: Text(
                        "Start Workout",
                        style: TextStyle(fontSize: 15, color: darkcolor, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Targeted Muscle",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Text(
                    workoutProgram.targetedMuscle!,
                    style: TextStyle(color: primarycolor, fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
