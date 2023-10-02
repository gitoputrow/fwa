import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/model/CalisthenicPark.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:free_workout_apps/widget/CustomButton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkDetailPageView extends StatelessWidget {
  final CalisthenicPark calisthenicPark;
  final LatLng userCoordinate;
  ParkDetailPageView({super.key, required this.calisthenicPark, required this.userCoordinate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: calisthenicPark.picture!,
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
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
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: primarycolor, value: progress.progress),
                            ),
                          );
                        },
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle, color: greycolor),
                                  child: Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    size: 25,
                                    color: primarycolor,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          calisthenicPark.name!,
                          style: TextStyle(
                              color: primarycolor, fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(IconlyBold.location, color: greycolor, size: 28),
                          SizedBox(
                            width: 7,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              calisthenicPark.fullAddress!,
                              style: TextStyle(
                                fontSize: 14,
                                color: greycolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 1,
                        color: primarycolor.withOpacity(0.8),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "DISTANCE",
                        style: TextStyle(
                            color: primarycolor, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${calisthenicPark.distance!.toStringAsFixed(1)} KM",
                        style: TextStyle(
                            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: primarycolor.withOpacity(0.8),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "TOOLS",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ExpandablePageView.builder(
                  controller: PageController(viewportFraction: 0.87),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: calisthenicPark.tools![index].picture!,
                          height: MediaQuery.of(context).size.height / 4.5,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 4.5,
                              width: MediaQuery.of(context).size.width,
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
                              height: MediaQuery.of(context).size.height / 4.5,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: primarycolor, value: progress.progress),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          calisthenicPark.tools![index].name!,
                          style: TextStyle(
                              color: primarycolor, fontSize: 18, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  itemCount: calisthenicPark.tools!.length,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7.5,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    color: primarycolor,
                    onPress: () async {
                      await launchUrl(
                          Uri.parse(calisthenicPark.linkMaps!
                              // "https://www.google.com/maps/dir/?api=1&origin=${userCoordinate.latitude},${userCoordinate.longitude}&destination=${calisthenicPark.latitude},${calisthenicPark.longitude}&dir_action=navigate&travelmode=driving"
                              ),
                          mode: LaunchMode.externalApplication);
                    },
                    text: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Maps",
                            style: TextStyle(
                                fontSize: 16, color: darkcolor, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.directions,
                            size: 25,
                            color: darkcolor,
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 24,
              )
            ],
          )
        ],
      ),
    );
  }
}
