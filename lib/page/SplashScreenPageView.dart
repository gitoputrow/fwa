import 'dart:async';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/DashboardPageView.dart';
// import 'package:pain/ValidationPage.dart';

class SplashScreenPageView extends StatefulWidget {
  @override
  _SplashScreenPageViewState createState() => _SplashScreenPageViewState();
}

class _SplashScreenPageViewState extends State<SplashScreenPageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    Timer(Duration(seconds: 3), () async {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPageView(),), (route) => false);
      // final user = await StorageProvider.getUserToken();
      // if (user != null) {
      //   Get.offNamed("/dashboard",arguments: 0);
      // } else {
      //   Get.off(HomeScreen());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Image.asset(
            "assets/ic_launcher.jpg",
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
