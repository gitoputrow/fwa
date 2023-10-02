import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/authentificationpage/registerpage/Register1PageView.dart';
import 'package:free_workout_apps/page/authentificationpage/registerpage/Register2PageView.dart';
import 'package:free_workout_apps/provider/global/AuthentificationProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterPageView extends StatefulWidget {

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextEditingController etFullName = TextEditingController();
  TextEditingController etHeight = TextEditingController();
  TextEditingController etWeight = TextEditingController();
  TextEditingController etUsername = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  TextEditingController etCPassword = TextEditingController();
  List<Widget> pages = [];
  @override
  void initState() {
     pages = [
      Register1PageView(
        etFullName: etFullName,
        etHeight: etHeight,
        etWeight: etWeight,
      ),
      Register2PageView(
        etCPassword: etCPassword,
        etUsername: etUsername,
        etPassword: etPassword,
      ),
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<AuthentificationProvider>(context, listen: false).previousPage(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: darkcolor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top -
                  MediaQuery.of(context).viewPadding.bottom,
              child: Stack(
                children: [
                  Consumer<AuthentificationProvider>(
                    builder: (context, controller, child) => PageView.builder(
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                      clipBehavior: Clip.none,
                      controller: controller.pageControllerAuth,
                      itemCount: pages.length,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 26, left: 24),
                      child: Consumer<AuthentificationProvider>(
                        builder: (context, controller, child) => InkWell(
                          onTap: () {
                            controller.previousPage(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Consumer<AuthentificationProvider>(
                          builder: (context, controller, child) => SmoothPageIndicator(
                              controller: controller.pageControllerAuth,
                              count: 2,
                              effect: ExpandingDotsEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: primarycolor,
                                  dotWidth: MediaQuery.of(context).size.width / 14,
                                  dotHeight: 12)),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer<AuthentificationProvider>(
                          builder: (context, controller, child) => CustomButton(
                              color: controller.nextPagePerm == true
                                  ? primarycolor
                                  : primarycolor.withOpacity(0.7),
                              onPress: () {
                                controller.nextPage(context,pages);
                              },
                              splashFactory:
                                  controller.nextPagePerm == true ? null : NoSplash.splashFactory,
                              text: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                    controller.indexRegist == pages.length - 1
                                        ? "Let's Workout"
                                        : "Next",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: controller.nextPagePerm == true
                                            ? darkcolor
                                            : darkcolor.withOpacity(0.7),
                                        fontWeight: FontWeight.w700)),
                              )),
                        ),
                        SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
