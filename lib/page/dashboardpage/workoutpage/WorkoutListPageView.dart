import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/dashboardpage/workoutpage/WorkoutStartPageView.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/PopUpAction.dart';
import 'package:free_workout_apps/widget/WorkoutListCard.dart';
import 'package:provider/provider.dart';

import '../../../model/WorkoutProgram.dart';
import '../../../provider/global/WorkoutProvider.dart';
import '../../../widget/CustomButton.dart';
import '../../../widget/WorkoutExerciseListCard.dart';

class WorkoutListPageView extends StatelessWidget {
  const WorkoutListPageView();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return Consumer<WorkoutProvider>(
              builder: (context, controller, child) => PopUpAction(
                  text: "Are you sure want to quit?\nyour progress will not be saved",
                  textBtn1: "Yes",
                  textBtn2: "No",
                  onPressAction1: () {
                    controller.resetVariable();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onPressAction2: () {
                    Navigator.pop(context);
                  }),
            );
          },
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: darkcolor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.1,
                  child: Stack(
                    children: [
                      Consumer<WorkoutProvider>(
                        builder: (context, controller, child) => Image.asset(
                          "assets/images/${controller.workoutData.name!.toLowerCase().replaceAll(" ", "")}pic.png",
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.1,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return Consumer<WorkoutProvider>(
                                    builder: (context, controller, child) => PopUpAction(
                                        text:
                                            "Are you sure want to quit?\nyour progress will not be saved",
                                        textBtn1: "Yes",
                                        textBtn2: "No",
                                        onPressAction1: () {
                                          controller.resetVariable();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        onPressAction2: () {
                                          Navigator.pop(context);
                                        }),
                                  );
                                },
                              ),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle, color: greycolor),
                                  child: Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    size: 25,
                                    color: primarycolor,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Consumer<WorkoutProvider>(
                          builder: (context, controller, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.isRest == true
                                    ? "REST"
                                    : controller.isDone == true
                                        ? "WELL DONE"
                                        : "GO",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, color: primarycolor, fontSize: 24),
                              ),
                              controller.isRest == true
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          width: MediaQuery.of(context).size.width / 4,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            color: greycolor.withOpacity(0.5),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                controller.formatTime(),
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Consumer<WorkoutProvider>(
                    builder: (context, controller, child) => Row(
                      children: [
                        Text(
                          "${controller.workoutData.name!} Exercise",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                        ),
                        Spacer(),
                        Text(
                          "Set ${controller.workoutIndex + 1} of ${controller.workoutData.level![controller.levelIndex].workoutData!.length}",
                          style: TextStyle(
                            color: primarycolor,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Consumer<WorkoutProvider>(
                        builder: (context, controller, child) {
                          print(controller.workoutData.level![controller.levelIndex].reps! +
                              2 *
                                  controller
                                      .userData
                                      .challangeData![controller.userData.challangeData!.indexWhere(
                                          (element) =>
                                              element.title == controller.workoutData.name)]
                                      .easy!);
                          return Column(
                            children: [
                              ListView.builder(
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: WorkoutExerciseListCard(
                                      isDone: controller.workoutIndex > index ||
                                          controller.isDone == true,
                                      workoutSet: index,
                                      workoutReps: controller.workoutData.level![controller.levelIndex].reps!,
                                      workoutData: controller.workoutData
                                          .level![controller.levelIndex].workoutData![index]),
                                ),
                                itemCount: controller
                                    .workoutData.level![controller.levelIndex].workoutData!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                              ),
                              SizedBox(
                                height: 85,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                          onPress: () async {
                            if (controller.isDone == true) {
                              controller.resetVariable();
                              await controller.finishedWorkout(context);
                            } else {
                              if (controller.isRest == true) {
                                controller.isRest = false;
                                controller.timer!.cancel();
                                controller.restTime = 30;
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WorkoutStartPageView(),
                                  ));
                            }
                          },
                          text: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                            child: Text(
                              controller.isDone == true ? "Done" : "Start Workout",
                              style: TextStyle(
                                  fontSize: 16, color: darkcolor, fontWeight: FontWeight.w700),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
