import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:free_workout_apps/page/dashboardpage/ParkPage/ParkDetailPageView.dart';
import 'package:free_workout_apps/page/dashboardpage/workoutpage/PrepareWorkoutPageView.dart';
import 'package:free_workout_apps/page/dashboardpage/workoutpage/WorkoutListPageView.dart';
import 'package:free_workout_apps/provider/global/DashboardProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomBottomSheet.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:free_workout_apps/widget/CustomRadioButton.dart';
import 'package:free_workout_apps/widget/LevelCard.dart';
import 'package:free_workout_apps/widget/ParkCard.dart';
import 'package:free_workout_apps/widget/WorkoutCard.dart';
import 'package:free_workout_apps/widget/WorkoutListCard.dart';
import 'package:provider/provider.dart';

import '../../provider/global/WorkoutProvider.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Consumer<DashboardProvider>(
              builder: (context, controller, child) => Row(
                children: [
                  // CircleAvatar(
                  //   backgroundColor: primarycolor,
                  //   radius: 35,
                  //   child: Icon(
                  //     Icons.person,
                  //     color: darkcolor,
                  //     size: 40,
                  //   ),
                  // ),
                  CachedNetworkImage(
                    imageUrl: controller.userData.photoprofile!,
                    // fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 35,
                              child: Icon(
                                Icons.person,
                                color: darkcolor,
                                size: 40,
                              ),
                            );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: primarycolor, value: progress.progress),
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return controller.userData.photoprofile == "null"
                          ? CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 35,
                              child: Icon(
                                Icons.person,
                                color: darkcolor,
                                size: 40,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 35,
                              backgroundImage: imageProvider,
                            );
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userData.name!,
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        controller.userData.username!,
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 15, color: greycolor),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 36,
            ),
            ExpandablePageView.builder(
              clipBehavior: Clip.none,
              physics: BouncingScrollPhysics(),
              controller: PageController(viewportFraction: 0.95),
              itemCount: Provider.of<DashboardProvider>(context).userData.challangeData!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: LevelCard(
                    challangeData:
                        Provider.of<DashboardProvider>(context).userData.challangeData![index],
                  ),
                );
              },
            ),
            // SizedBox(
            //   height: 28,
            // ),
            // Divider(
            //   color: blackcolor,
            //   height: 2,
            //   thickness: 2,
            // ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Workout Program",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: primarycolor),
            ),
            SizedBox(
              height: 16,
            ),
            Consumer<DashboardProvider>(
              builder: (context, controller, child) => Row(
                children: [
                  CustomRadioButton(
                      onTap: () {
                        controller.sortingProgram("all type");
                      },
                      text: "All Type",
                      isActive: controller.sortProgram == "all type"),
                  SizedBox(
                    width: 16,
                  ),
                  CustomRadioButton(
                      onTap: () {
                        controller.sortingProgram("upper body");
                      },
                      text: "Upper Body",
                      isActive: controller.sortProgram == "upper body"),
                  SizedBox(
                    width: 16,
                  ),
                  CustomRadioButton(
                      onTap: () {
                        controller.sortingProgram("lower body");
                      },
                      text: "Lower Body",
                      isActive: controller.sortProgram == "lower body"),
                  SizedBox(
                    width: 16,
                  ),
                  CustomRadioButton(
                      onTap: () {
                        controller.sortingProgram("cardio");
                      },
                      text: "Cardio",
                      isActive: controller.sortProgram == "cardio"),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Consumer2<DashboardProvider, WorkoutProvider>(
              builder: (context, controllerDashboard, controllerWorkout, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: WorkoutCard(
                        workoutProgram: controllerDashboard.workoutProgramTemp[index],
                        onpressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return CustomBottomSheet(
                                  exerciseName: controllerDashboard.workoutProgramTemp[index].name!,
                                  ontab: (p0) {
                                    controllerWorkout.levelIndex = p0;
                                  },
                                  onpressed: () {
                                    Navigator.pop(context);
                                    controllerWorkout.workoutData =
                                        controllerDashboard.workoutProgramTemp[index];
                                    controllerWorkout.workoutIndexData = index;
                                    controllerWorkout.userData = controllerDashboard.userData;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PrepareWorkoutPageView(
                                            workoutName: controllerWorkout.workoutData.name!,
                                          ),
                                        ));
                                  },
                                  widgetTab1: ListView.builder(
                                    itemBuilder: (context, i) => Padding(
                                      padding: const EdgeInsets.only(bottom: 36),
                                      child: WorkoutListCard(
                                          workoutData: controllerDashboard
                                              .workoutProgramTemp[index].level![0].workoutData![i],
                                          workoutSet: i + 1,
                                          workoutReps: controllerDashboard
                                                  .workoutProgramTemp[index].level![0].reps!),
                                    ),
                                    itemCount: controllerDashboard
                                        .workoutProgramTemp[index].level![0].workoutData!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                  ),
                                  widgetTab2: ListView.builder(
                                    itemBuilder: (context, i) => Padding(
                                      padding: const EdgeInsets.only(bottom: 36),
                                      child: WorkoutListCard(
                                          workoutData: controllerDashboard
                                              .workoutProgramTemp[index].level![1].workoutData![i],
                                          workoutSet: i + 1,
                                          workoutReps: controllerDashboard
                                                  .workoutProgramTemp[index].level![1].reps!),
                                    ),
                                    itemCount: controllerDashboard
                                        .workoutProgramTemp[index].level![1].workoutData!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                  ));
                            },
                          );
                        }),
                  ),
                  itemCount: controllerDashboard.workoutProgramTemp.length,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
