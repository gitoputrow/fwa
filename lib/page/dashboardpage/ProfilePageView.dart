import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/profilepage/EditAccountPageView.dart';
import 'package:free_workout_apps/page/profilepage/EditProfilePageView.dart';
import 'package:free_workout_apps/page/profilepage/MyBodyPageView.dart';
import 'package:free_workout_apps/provider/global/DashboardProvider.dart';
import 'package:free_workout_apps/provider/global/EditUserProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:free_workout_apps/widget/CustomShimmer.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../widget/PopUpAction.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Profile",
                    style:
                        TextStyle(color: primarycolor, fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  // SizedBox(
                  //   height: 4,
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width / 3.2,
                  //   child: Divider(
                  //     color: primarycolor.withOpacity(0.7),
                  //     thickness: 1,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 4,
                  // ),
                  // Text(
                  //   Provider.of<DashboardProvider>(context).userData.username!,
                  //   style: TextStyle(color: greycolor, fontSize: 18, fontWeight: FontWeight.w500),
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Consumer<DashboardProvider>(
            builder: (context, controller, child) => controller.startPage == true
                ? Container(
                    padding: EdgeInsets.all(16),
                    decoration:
                        BoxDecoration(color: blackcolor, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CachedNetworkImage(
                          imageUrl: controller.userData.photoprofile!,
                          // fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 53,
                              child: Icon(
                                Icons.person,
                                color: darkcolor,
                                size: 40,
                              ),
                            );
                          },
                          progressIndicatorBuilder: (context, url, progress) {
                            return Shimmer.fromColors(
                              enabled: true,
                              baseColor: Colors.grey.shade200.withOpacity(.5),
                              highlightColor: Colors.grey.shade300.withOpacity(.8),
                              child: CircleAvatar(
                                radius: 53,
                                backgroundColor: Colors.grey,
                              ),
                            );
                            ;
                          },
                          imageBuilder: (context, imageProvider) {
                            return Provider.of<DashboardProvider>(context).userData.photoprofile ==
                                    "null"
                                ? CircleAvatar(
                                    backgroundColor: primarycolor,
                                    radius: 53,
                                    child: Icon(
                                      Icons.person,
                                      color: darkcolor,
                                      size: 40,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: primarycolor,
                                    radius: 53,
                                    backgroundImage: imageProvider,
                                  );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            controller.userData.username!,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: primarycolor, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: primarycolor,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "${controller.userData.name!}",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: greycolor,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Weight",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: primarycolor,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "${controller.userData.weight!} Kg",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: greycolor,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Height",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: primarycolor,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "${controller.userData.height!} Cm",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: greycolor,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EditProfilePageView()))
                                .then((value) async =>
                                    await Provider.of<DashboardProvider>(context, listen: false)
                                        .getUserData(context));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: greycolor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: primarycolor,
                                  size: 22,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Edit Profile",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: primarycolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: primarycolor,
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  )
                : CustomShimmer(height: MediaQuery.of(context).size.height / 2.8),
          ),
          SizedBox(
            height: 36,
          ),
          Consumer<DashboardProvider>(
            builder: (context, controller, child) => controller.startPage == true
                ? CustomButtonMenu(
                    onTap: () {
                      Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditAccountPageView()))
                          .then((value) async =>
                              await Provider.of<DashboardProvider>(context, listen: false)
                                  .getUserData(context));
                    },
                    icons: Icons.person,
                    text: "Edit Account")
                : CustomShimmer(height: MediaQuery.of(context).size.height * 0.067,borderRadius: 12,),
          ),
          SizedBox(
            height: 24,
          ),
          Consumer<DashboardProvider>(
            builder: (context, controller, child) => controller.startPage == true
                ? CustomButtonMenu(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyBodyPageView()));
              },
              icons: Icons.photo,
              text: "My Body")
                : CustomShimmer(height: MediaQuery.of(context).size.height * 0.067,borderRadius: 12,),
          ),
          
          SizedBox(
            height: 24,
          ),
          Consumer<DashboardProvider>(
            builder: (context, controller, child) => controller.startPage == true
                ? CustomButtonMenu(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => PopUpAction(
                          borderColor: Colors.redAccent,
                          text: "Are you sure want to delete this account?",
                          textBtn1: "Yes",
                          textBtn2: "No",
                          onPressAction1: () async {
                            await Provider.of<DashboardProvider>(context, listen: false)
                                .deleteAccount(context);
                          },
                          onPressAction2: () {
                            Navigator.pop(context);
                          },
                        ));
              },
              icons: Icons.delete,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              iconColor: Colors.white,
              text: "Delete Account")
                : CustomShimmer(height: MediaQuery.of(context).size.height * 0.067,borderRadius: 12,),
          ),
          SizedBox(height: 24),
          Consumer<DashboardProvider>(
            builder: (context, controller, child) => controller.startPage == true
                ? CustomButtonMenu(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => PopUpAction(
                          borderColor: Colors.redAccent,
                          text: "Are you sure want to logout?",
                          textBtn1: "Yes",
                          textBtn2: "No",
                          onPressAction1: () async {
                            Navigator.pop(context);
                            await Provider.of<DashboardProvider>(context, listen: false)
                                .logout(context);
                          },
                          onPressAction2: () {
                            Navigator.pop(context);
                          },
                        ));
              },
              icons: IconlyBold.logout,
              textColor: Colors.redAccent,
              iconColor: Colors.redAccent,
              text: "Logout")
                : CustomShimmer(height: MediaQuery.of(context).size.height * 0.067,borderRadius: 12,),
          ),
          
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
