import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:free_workout_apps/page/authentificationpage/LoginPageView.dart';
import 'package:free_workout_apps/page/authentificationpage/RegisterPageView.dart';
import 'package:free_workout_apps/widget/BasicLoader.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:free_workout_apps/widget/ToastMessageCustom.dart';

import '../values/Colors.dart';

class HomeScreenPageView extends StatelessWidget {
  const HomeScreenPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkcolor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/bgHomeScreen.png"),
                  fit: BoxFit.cover,
                  opacity: 0.45)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(),
              SizedBox(
                height: 28,
              ),
              Text(
                "GOOD SHAPE",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 48, color: primarycolor, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "HEALTHY BODY",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 48, color: primarycolor, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "With this app, you can try different types of training with your body weight and find a park to workout in free",
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      color: primarycolor,
                      onPress: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPageView(),)),
                      text: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Getting Started",
                          style: TextStyle(
                              fontSize: 20, color: darkcolor, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    CustomButton(
                      color: blackcolor,
                      onPress: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPageView(),
                          )),
                      borderColor: primarycolor,
                      text: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Get in Shape",
                          style: TextStyle(
                              fontSize: 20, color: primarycolor, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
