import 'dart:async';

import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/dashboardpage/workoutpage/WorkoutListPageView.dart';
import 'package:free_workout_apps/provider/component/PrepareAnimationProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:provider/provider.dart';

import '../../../model/WorkoutProgram.dart';
import '../../../provider/global/WorkoutProvider.dart';

class PrepareWorkoutPageView extends StatelessWidget {
  final String workoutName;
  const PrepareWorkoutPageView({super.key, required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrepareAnimationProvider(),
      builder: (context, child) => PrepareWorkoutAnimation(
        workoutName: workoutName,
      ),
    );
  }
}

class PrepareWorkoutAnimation extends StatefulWidget {
  final String workoutName;

  const PrepareWorkoutAnimation({super.key, required this.workoutName});

  @override
  State<PrepareWorkoutAnimation> createState() => _PrepareWorkoutAnimationState();
}

class _PrepareWorkoutAnimationState extends State<PrepareWorkoutAnimation> {
  @override
  void initState() {
    context.read<PrepareAnimationProvider>().startAnimation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: Stack(
        children: [
          AnimatedScale(
            scale: context.read<PrepareAnimationProvider>().scaleText,
            duration: Duration(
                milliseconds:
                    context.watch<PrepareAnimationProvider>().isCountDown == false ? 1000 : 550),
            curve: Curves.easeInBack,
            child: AnimatedOpacity(
              duration: Duration(
                  milliseconds:
                      context.watch<PrepareAnimationProvider>().isCountDown == false ? 1000 : 550),
              curve: Curves.easeInQuart,
              opacity: context.read<PrepareAnimationProvider>().opacityText,
              child: Center(
                  child: context.watch<PrepareAnimationProvider>().isCountDown == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Ready",
                              style: TextStyle(
                                  color: primarycolor, fontSize: 36, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${widget.workoutName} Exercise",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.1),
                            ),
                          ],
                        )
                      : Text(
                          context.read<PrepareAnimationProvider>().countDown.toString(),
                          style: TextStyle(
                              color: primarycolor, fontSize: 40, fontWeight: FontWeight.w700),
                        )),
            ),
          ),
          SafeArea(
            child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutListPageView(),
                      ));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
