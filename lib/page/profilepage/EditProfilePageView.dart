import 'dart:async';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/model/UserData.dart';
import 'package:free_workout_apps/page/dashboardpage/workoutpage/WorkoutListPageView.dart';
import 'package:free_workout_apps/provider/component/PrepareAnimationProvider.dart';
import 'package:free_workout_apps/provider/global/EditUserProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomBottomSheetPic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../model/WorkoutProgram.dart';
import '../../../provider/global/WorkoutProvider.dart';
import '../../provider/component/DropDownButtonValueProvider.dart';
import '../../widget/CustomButton.dart';
import '../../widget/CustomTextInput.dart';

class EditProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditUserProvider(),
      builder: (context, child) => EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    Provider.of<EditUserProvider>(context, listen: false).onInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                child: SizedBox(
                  height: 28,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: primarycolor,
                    ),
                  ),
                  // Text(
                  //   "Edit Profile",
                  //   textScaleFactor: 1,
                  //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primarycolor),
                  // ),
                  Icon(
                    Icons.arrow_back_ios,
                    color: primarycolor.withOpacity(0),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Change Your Profile",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primarycolor),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "You Can Edit Your Personal Infomation",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 18, color: primarycolor),
              ),
              SizedBox(
                height: 32,
              ),
              Consumer<EditUserProvider>(
                builder: (context, provider, child) => provider.startPage == false
                    ? Center(
                        child: CircularProgressIndicator(color: primarycolor),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: blackcolor, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 24,
                            ),
                            Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 9.3,
                                width: MediaQuery.of(context).size.width / 4.15,
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: provider.userData.photoprofile!,
                                      // fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return CircleAvatar(
                                          backgroundColor: primarycolor,
                                          radius: 53,
                                          backgroundImage: provider.imageSource == null
                                              ? null
                                              : Image.file(provider.imageSource!).image,
                                          child: provider.imageSource == null
                                              ? Icon(
                                                  Icons.person,
                                                  color: darkcolor,
                                                  size: 40,
                                                )
                                              : null,
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
                                        return provider.userData.photoprofile == "null"
                                            ? CircleAvatar(
                                                backgroundColor: primarycolor,
                                                radius: 53,
                                                backgroundImage: provider.imageSource == null
                                                    ? null
                                                    : Image.file(provider.imageSource!).image,
                                                child: provider.imageSource == null
                                                    ? Icon(
                                                        Icons.person,
                                                        color: darkcolor,
                                                        size: 40,
                                                      )
                                                    : null,
                                              )
                                            : CircleAvatar(
                                                backgroundColor: primarycolor,
                                                radius: 53,
                                                backgroundImage: provider.imageSource == null
                                                    ? imageProvider
                                                    : Image.file(provider.imageSource!).image,
                                              );
                                      },
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      padding: const EdgeInsets.only(
                                        bottom: 4,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(30))),
                                            backgroundColor: darkcolor,
                                            builder: (context) {
                                              return CustomBottomSheetPic(
                                                  ontapCamera: () =>
                                                      provider.PickImage(ImageSource.camera,context),
                                                  ontapPicture: () =>
                                                      provider.PickImage(ImageSource.gallery,context));
                                            },
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: darkcolor,
                                          child: Icon(
                                            Icons.add,
                                            color: primarycolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, value, child) => CustomTextInput(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  textEditingController: value.etFullName,
                                  hintText: provider.userData.name!,
                                  textInputType: TextInputType.name,
                                  title: "Full Name"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, value, child) => CustomTextInput(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  textEditingController: value.etWeight,
                                  hintText: provider.userData.weight!,
                                  textInputType: TextInputType.number,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 14, left: 4),
                                    child: Text(
                                      "KG",
                                      style: TextStyle(
                                          color: primarycolor.withOpacity(0.8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  title: "Weight"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, value, child) => CustomTextInput(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  textEditingController: value.etHeight,
                                  hintText: provider.userData.height!,
                                  textInputType: TextInputType.number,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 14),
                                    child: Text(
                                      "CM",
                                      style: TextStyle(
                                          color: primarycolor.withOpacity(0.8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  title: "Height"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: primarycolor.withOpacity(0.8)),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, provider, child) => DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  items: provider.items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              color: primarycolor,
                                              fontSize: 18,
                                            ),
                                          )))
                                      .toList(),
                                  dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: blackcolor,
                                      border: Border.all(
                                          color: primarycolor.withOpacity(0.6), width: 1))),
                                  onChanged: (value) {
                                    provider.selectedValue = value as String;

                                    // AuthentificationProvider.read(context).gender = value as String;
                                    // controller.buttonPermissionEP();
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8, top: 2, bottom: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: blackcolor,
                                      border: Border.all(
                                          color: primarycolor.withOpacity(0.6), width: 1))
                                  ),
                                  
                                  value: provider.selectedValue,
                                
                                  selectedItemBuilder: ((context) {
                                    return provider.items
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: primarycolor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            )))
                                        .toList();
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CustomButton(
                                color: primarycolor,
                                onPress: () async {
                                  await provider.updateProfile(context);
                                },
                                text: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "Update Profile",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: darkcolor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            SizedBox(
                              height: 32,
                            )
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
