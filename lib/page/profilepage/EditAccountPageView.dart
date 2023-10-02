import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/component/PasswordPeekerProvider.dart';
import '../../provider/global/EditUserProvider.dart';
import '../../values/Colors.dart';
import '../../widget/CustomBottomSheetPic.dart';
import '../../widget/CustomButton.dart';
import '../../widget/CustomTextInput.dart';

class EditAccountPageView extends StatelessWidget {
  const EditAccountPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditUserProvider(),
      builder: (context, child) => EditAccountPage(),
    );
  }
}

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  get greyColor => null;

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
                  Text(
                    "Edit Account",
                    textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primarycolor),
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    color: primarycolor.withOpacity(0),
                  ),
                ],
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
                            Text(
                              "Change Your Username",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: primarycolor),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "You Can Change Your Username If It's not been used",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: 14, color: primarycolor),
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, value, child) => CustomTextInput(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  textEditingController: value.etUserName,
                                  hintText: "Username",
                                  textInputType: TextInputType.name,
                                  title: ""),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 0.8,
                          dashLength: 14.0,
                          dashColor: greycolor,
                          dashGapLength: 7.0,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                              height: 28,
                            ),
                        Text(
                              "Change Your Password",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: primarycolor),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "You Can Change Your Password With the new one",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: 14, color: primarycolor),
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, value, child) => CustomTextInput(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  textEditingController: value.etOldPass,
                                  hintText: "Current Password",
                                  obscureText: value.isInvisibleOldPass,
                                  textInputType: TextInputType.name,
                                  suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () => value.isInvisibleOldPass = value.isInvisibleOldPass == true ? false : true,
                          child: Icon(
                            value.isInvisibleOldPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: primarycolor.withOpacity(0.6),
                          ),
                        ),
                      ),
                                  title: ""),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Consumer<EditUserProvider>(
                              builder: (context, value, child) => CustomTextInput(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  textEditingController: value.etNewPass,
                                  hintText: "New Password",
                                  obscureText: value.isInvisibleNewPass,
                                  textInputType: TextInputType.name,
                                  suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () => value.isInvisibleNewPass = value.isInvisibleNewPass == true ? false : true,
                          child: Icon(
                            value.isInvisibleNewPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: primarycolor.withOpacity(0.6),
                          ),
                        ),
                      ),
                                  title: ""),
                            ),
                            
                            SizedBox(
                              height: 40,
                            ),
                            CustomButton(
                                color: primarycolor,
                                onPress: () async {
                                  await provider.updateAccount(context);
                                },
                                text: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "Update Account",
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
