import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/profilepage/EditAccountPageView.dart';
import 'package:free_workout_apps/page/profilepage/EditProfilePageView.dart';
import 'package:free_workout_apps/page/profilepage/MyBodyPageView.dart';
import 'package:free_workout_apps/provider/global/DashboardProvider.dart';
import 'package:free_workout_apps/provider/global/EditUserProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

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
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: blackcolor, borderRadius: BorderRadius.circular(16)),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: Provider.of<DashboardProvider>(context).userData.photoprofile!,
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
                    return SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: primarycolor, value: progress.progress),
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Provider.of<DashboardProvider>(context).userData.photoprofile == "null"
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
                    Provider.of<DashboardProvider>(context, listen: false).userData.username!,
                    textScaleFactor: 1,
                    style:
                        TextStyle(color: primarycolor, fontSize: 18, fontWeight: FontWeight.bold),
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
                      "${Provider.of<DashboardProvider>(context, listen: false).userData.name!}",
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
                      "${Provider.of<DashboardProvider>(context, listen: false).userData.weight!} Kg",
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
                      "${Provider.of<DashboardProvider>(context, listen: false).userData.height!} Cm",
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
                    Navigator.push(
                            context, MaterialPageRoute(builder: (context) => EditProfilePageView()))
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
                              color: primarycolor, fontSize: 16, fontWeight: FontWeight.bold),
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
          ),
          SizedBox(
            height: 36,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (context) => EditAccountPageView()))
                  .then((value) async =>
                      await Provider.of<DashboardProvider>(context, listen: false)
                          .getUserData(context));
            },
            child: Container(
              decoration: BoxDecoration(
                color: blackcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: primarycolor,
                    size: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Edit Account",
                    textScaleFactor: 1,
                    style:
                        TextStyle(color: primarycolor, fontSize: 18, fontWeight: FontWeight.bold),
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
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyBodyPageView()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: blackcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.photo,
                    color: primarycolor,
                    size: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "My Body",
                    textScaleFactor: 1,
                    style:
                        TextStyle(color: primarycolor, fontSize: 18, fontWeight: FontWeight.bold),
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
          SizedBox(
            height: 24,
          ),
          InkWell(
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Delete Account",
                    textScaleFactor: 1,
                    style:
                        TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
          SizedBox(height: 24),
          InkWell(
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
            child: Container(
              decoration: BoxDecoration(
                color: blackcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    IconlyBold.logout,
                    color: Colors.redAccent,
                    size: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Logout",
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
