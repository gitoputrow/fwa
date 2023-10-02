import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../values/Colors.dart';

class CustomButtonSortBy extends StatelessWidget {
  final String selected;
  final void Function() ontap1;
  final void Function() ontap2;
  const CustomButtonSortBy({super.key, required this.selected, required this.ontap1, required this.ontap2});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: blackcolor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Container(
                    alignment: Alignment.center,
                    height: 6,
                    width: MediaQuery.of(context).size.width / 6,
                    decoration:
                        BoxDecoration(color: greycolor, borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Sort By",textScaleFactor: 1,style: TextStyle(
                    color: primarycolor,fontSize: 18,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: ontap1,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 6,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(
                              color: selected == "distance" ? primarycolor : blackcolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primarycolor, width: 1)),
                          child: Center(
                            child: Text(
                              "Distance",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color:  selected == "distance" ? blackcolor : primarycolor, fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ontap2,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 6,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(
                              color: selected == "name" ? primarycolor : blackcolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primarycolor, width: 1)),
                          child: Center(
                            child: Text(
                              "Name",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: selected == "name" ? blackcolor : primarycolor, fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        // decoration: BoxDecoration(
        //     color: blackcolor,
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: primarycolor.withOpacity(0.5), width: 1)),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.filter,
              color: primarycolor,
              size: 26,
            ),
            // SizedBox(
            //   width: 8,
            // ),
            // Text(
            //   "Sort By",
            //   textScaleFactor: 1,
            //   style: TextStyle(color: primarycolor, fontWeight: FontWeight.w700, fontSize: 14),
            // )
          ],
        ),
      ),
    );
  }
}
