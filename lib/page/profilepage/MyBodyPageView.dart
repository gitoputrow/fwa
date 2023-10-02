import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/page/profilepage/MyBodyPreviewPageView.dart';
import 'package:free_workout_apps/provider/global/MyBodyProvider.dart';
import 'package:free_workout_apps/values/Colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widget/CustomBottomSheetPic.dart';

class MyBodyPageView extends StatefulWidget {
  const MyBodyPageView({super.key});

  @override
  State<MyBodyPageView> createState() => _MyBodyPageViewState();
}

class _MyBodyPageViewState extends State<MyBodyPageView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<MyBodyProvider>(context, listen: false).onInit(context);
    });

    // print(Provider.of<DashboardController>(context, listen: false).startPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: SizedBox(
                height: 28,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: primarycolor,
              ),
            ),
            // Text
            SizedBox(
              height: 16,
            ),
            Text(
              "My Body",
              textScaleFactor: 1,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primarycolor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "See all Photo of Your Body",
              textScaleFactor: 1,
              style: TextStyle(fontSize: 18, color: primarycolor),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: Stack(
                children: [
                  Consumer<MyBodyProvider>(
                    builder: (context, value, child) => value.startPage == false
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primarycolor,
                            ),
                          )
                        : GridView.builder(
                            padding:
                                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 7),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                            physics: BouncingScrollPhysics(),
                            itemCount: value.photoData.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  value.photoDataSelected = value.photoData[index];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyBodyPreviewPageView(),
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 2)),
                                  child: CachedNetworkImage(
                                    imageUrl: value.photoData[index].photoUrl!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: greycolor,
                                        child: Text('Error'),
                                      );
                                    },
                                    progressIndicatorBuilder: (context, url, progress) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: primarycolor, value: progress.progress),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Consumer<MyBodyProvider>(
                          builder: (context, value, child) => InkWell(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                              backgroundColor: darkcolor,
                              builder: (context) {
                                return CustomBottomSheetPic(
                                    ontapCamera: () async =>
                                        await value.PickImage(ImageSource.camera, context)
                                            .then((value) => Navigator.pop(context)),
                                    ontapPicture: () async =>
                                        await value.PickImage(ImageSource.gallery, context)
                                            .then((value) => Navigator.pop(context)));
                              },
                            ),
                            child: Container(
                              // margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: greycolor),
                              child: Icon(
                                Icons.add,
                                color: primarycolor,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
