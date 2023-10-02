import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/model/WorkoutProgram.dart';

import '../values/Colors.dart';

class WorkoutExerciseListCard extends StatelessWidget {
  final WorkoutData workoutData;
  final int workoutSet;
  final int workoutReps;
  final bool isDone;
  const WorkoutExerciseListCard(
      {super.key,
      required this.workoutData,
      required this.workoutSet,
      required this.workoutReps,
      required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: blackcolor,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 41, 44, 45),
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    Icons.check,
                    color: primarycolor,
                  ),
                ),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: blackcolor.withOpacity(isDone == true ? 0 : 0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 70,
              width: 70,
              child: CachedNetworkImage(
                imageUrl: workoutData.workoutPreview!,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
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
                    height: 70,
                    child: Center(
                      child:
                          CircularProgressIndicator(color: primarycolor, value: progress.progress),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workoutData.title!,
                style: TextStyle(color: primarycolor, fontSize: 19, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "$workoutReps Reps",
                style: TextStyle(color: primarycolor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            height: 50,
            child: VerticalDivider(
              color: primarycolor,
              width: 2,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                "Set",
                style: TextStyle(color: primarycolor, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "${workoutSet + 1}",
                style: TextStyle(color: primarycolor, fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
