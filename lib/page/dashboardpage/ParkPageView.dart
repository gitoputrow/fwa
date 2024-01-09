import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/dashboardpage/ParkPage/ParkDetailPageView.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:free_workout_apps/widget/CustomButtonSortBy.dart';
import 'package:free_workout_apps/widget/CustomSearchTextField.dart';
import 'package:free_workout_apps/widget/CustomShimmer.dart';
import 'package:free_workout_apps/widget/ParkCard.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/global/DashboardProvider.dart';

class ParkPageView extends StatelessWidget {
  const ParkPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calisthenics Park",
                style: TextStyle(color: primarycolor, fontWeight: FontWeight.w700, fontSize: 24),
              ),
              Consumer<DashboardProvider>(
                builder: (context, controller, child) => controller.startPage == true ? CustomButtonSortBy(
                    ontap1: () => controller.sortingCalisthenicPark("distance", context),
                    ontap2: () => controller.sortingCalisthenicPark("name", context),
                    selected: controller.sortPark) : CustomShimmer(height: MediaQuery.of(context).size.height * 0.031, width: 40,),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Consumer<DashboardProvider>(
          builder: (context, controller, child) => controller.startPage == false
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: CustomShimmer(height: MediaQuery.of(context).size.height / 2.5),
                )
              : controller.calisthenicPark.length == 0
                  ? SizedBox()
                  : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 24),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: ParkCard(
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ParkDetailPageView(
                                        calisthenicPark: controller.calisthenicPark[index],
                                        userCoordinate: controller.userCoordinate,
                                      ),
                                    ));
                              },
                              calisthenicPark: controller.calisthenicPark[index]),
                        ),
                        itemCount: controller.calisthenicPark.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                      ),
                  ),
        )
      ],
    );
  }
}
