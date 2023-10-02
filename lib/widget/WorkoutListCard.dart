import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/model/WorkoutProgram.dart';

import '../values/Colors.dart';

class WorkoutListCard extends StatelessWidget {
  final WorkoutData workoutData;
  final int workoutSet;
  final int workoutReps;
  const WorkoutListCard(
      {super.key,
      required this.workoutData,
      required this.workoutSet,
      required this.workoutReps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 80,
            width: 80,
            child: CachedNetworkImage(
              imageUrl: workoutData.workoutPreview!,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Center(
                    child: Text(
                      "image_not_found",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ),
                );
              },
              progressIndicatorBuilder: (context, url, progress) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(color: primarycolor, value: progress.progress),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workoutData.title!,
              style: TextStyle(color: primarycolor, fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Set $workoutSet",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.brightness_1,
                  color: greycolor,
                  size: 12,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "$workoutReps reps",
                  style: TextStyle(color: primarycolor, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
