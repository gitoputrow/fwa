import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/model/CalisthenicPark.dart';
import 'package:iconly/iconly.dart';
import '../values/Colors.dart';
import 'CustomButton.dart';

class ParkCard extends StatelessWidget {
  final CalisthenicPark calisthenicPark;
  final void Function() ontap;

  const ParkCard({super.key, required this.ontap, required this.calisthenicPark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: blackcolor,
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 39,
          //     color: primarycolor.withOpacity(0.05),
          //     offset: Offset(0, -7)
          //   )
          // ]
          // border: Border.all(color: primarycolor.withOpacity(0.5), width: 1)
        ),
      padding: const EdgeInsets.all(28),
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: calisthenicPark.picture!,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Text(
                    "image_not_found",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ),
              );
            },
            progressIndicatorBuilder: (context, url, progress) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Center(
                  child: CircularProgressIndicator(color: primarycolor, value: progress.progress),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            calisthenicPark.name!,
            style: TextStyle(color: primarycolor, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                IconlyBold.location,
                color: greycolor,
                size: 19,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                calisthenicPark.displayAddress!,
                style: TextStyle(color: greycolor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Distance : ${calisthenicPark.distance!.toStringAsFixed(1)} KM",
            style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 12,
          ),
          CustomButton(
              color: primarycolor,
              onPress: ontap,
              borderRadius: 12,
              text: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: Text(
                  "See Detail",
                  style: TextStyle(fontSize: 15, color: darkcolor, fontWeight: FontWeight.w700),
                ),
              ))
        ],
      ),
    );
  }
}
