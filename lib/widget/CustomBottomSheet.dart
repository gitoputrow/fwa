import 'package:flutter/material.dart';

import '../values/Colors.dart';
import 'CustomButton.dart';

class CustomBottomSheet extends StatelessWidget {
  final String exerciseName;
  final void Function() onpressed;
  final void Function(int) ontab;
  final Widget? widgetTab1;
  final Widget? widgetTab2;
  const CustomBottomSheet(
      {super.key,
      required this.exerciseName,
      required this.onpressed,
      required this.ontab,
      this.widgetTab1,
      this.widgetTab2});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: blackcolor,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 6,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration:
                        BoxDecoration(color: greycolor, borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "$exerciseName Exercise",
                    style:
                        TextStyle(color: primarycolor, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3.6),
                    decoration:
                        BoxDecoration(color: greycolor, borderRadius: BorderRadius.circular(8)),
                    child: TabBar(
                      labelColor: darkcolor,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: ontab,
                      unselectedLabelColor: primarycolor,
                      labelPadding: EdgeInsets.symmetric(vertical: 6),
                      indicator: BoxDecoration(
                          color: primarycolor, borderRadius: BorderRadius.circular(8)),
                      dividerHeight: 0,
                      tabs: [
                        Text("Easy"),
                        Text("Hard"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Flexible(
                    child: TabBarView(children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              widgetTab1!,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width / 5),
                                child: CustomButton(
                                    borderRadius: 24,
                                    color: primarycolor,
                                    onPress: onpressed,
                                    text: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                      child: Text(
                                        "Start Workout",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: darkcolor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 28,
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              widgetTab2!,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width / 5),
                                child: CustomButton(
                                    borderRadius: 24,
                                    color: primarycolor,
                                    onPress: onpressed,
                                    text: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                      child: Text(
                                        "Start Workout",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: darkcolor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 28,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
