import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:free_workout_apps/page/dashboardpage/HomePageView.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../provider/global/DashboardProvider.dart';

class DashboardPageView extends StatefulWidget {
  final int currentPage;

  const DashboardPageView({super.key, this.currentPage = 0});
  @override
  State<DashboardPageView> createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<DashboardProvider>(context, listen: false).currentPage = widget.currentPage;
      await Provider.of<DashboardProvider>(context, listen: false).onInit(context);
    });

    // print(Provider.of<DashboardController>(context, listen: false).startPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, controller, child) => Scaffold(
            backgroundColor: darkcolor,
            body: SafeArea(
              child: controller.pages[controller.currentPage],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: BottomNavigationBar(
                elevation: 0,
                onTap: controller.changePage,
                currentIndex: controller.currentPage,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                backgroundColor: darkcolor,
                items: [
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        IconlyBold.home,
                        size: 33,
                        color: primarycolor,
                      ),
                      icon: Icon(
                        IconlyLight.home,
                        size: 33,
                        color: primarycolor,
                      ),
                      label: "a",
                      backgroundColor: darkcolor),
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        IconlyBold.location,
                        size: 33,
                        color: primarycolor,
                      ),
                      icon: Icon(
                        IconlyLight.location,
                        size: 33,
                        color: primarycolor,
                      ),
                      label: "a",
                      backgroundColor: darkcolor),
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        IconlyBold.profile,
                        size: 33,
                        color: primarycolor,
                      ),
                      icon: Icon(
                        IconlyLight.profile,
                        size: 33,
                        color: primarycolor,
                      ),
                      label: "a",
                      backgroundColor: darkcolor),
                ],
              ),
            )));
  }
}
