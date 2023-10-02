import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/global/WorkoutProvider.dart';
import '../../../values/Colors.dart';
import '../../../widget/CustomButton.dart';

class WorkoutStartPageView extends StatelessWidget {
  const WorkoutStartPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: [
                Consumer<WorkoutProvider>(
                  builder: (context, controller, child) => CachedNetworkImage(
                    imageUrl: controller.workoutData.level![controller.levelIndex]
                        .workoutData![controller.workoutIndex].workoutExample!,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.5,
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
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: primarycolor, value: progress.progress),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: greycolor),
                            child: Icon(
                              Icons.keyboard_arrow_left_outlined,
                              size: 25,
                              color: primarycolor,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 13,
          ),
          Consumer<WorkoutProvider>(
            builder: (context, controller, child) => Text(
              "${controller.workoutData.level![controller.levelIndex].workoutData![controller.workoutIndex].title!.toUpperCase()}",
              style: TextStyle(color: primarycolor, fontWeight: FontWeight.w700, fontSize: 32),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Consumer<WorkoutProvider>(
            builder: (context, controller, child) => Text(
                    "${controller.workoutData.level![controller.levelIndex].reps!} Reps",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26),
                  )
                ,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<WorkoutProvider>(
                  builder: (context, controller, child) => CustomButton(
                      borderRadius: 24,
                      color: primarycolor,
                      onPress: () {
                        controller.nextWorkout();
                        Navigator.pop(context);
                      },
                      text: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: Text(
                          "Next Workout",
                          style: TextStyle(
                              fontSize: 16, color: darkcolor, fontWeight: FontWeight.w700),
                        ),
                      )),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
