import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/provider/global/MyBodyProvider.dart';
import 'package:provider/provider.dart';

import '../../values/Colors.dart';
import '../../widget/PopUpAction.dart';

class MyBodyPreviewPageView extends StatelessWidget {
  const MyBodyPreviewPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(
              imageUrl: Provider.of<MyBodyProvider>(context).photoDataSelected.photoUrl!,
              fit: BoxFit.fitHeight,
              errorWidget: (context, url, error) {
                return Container(
                  color: greycolor,
                  child: Text('Error'),
                );
              },
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(color: primarycolor, value: progress.progress),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(height: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: darkcolor),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: primarycolor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: darkcolor),
                      child: InkWell(
                        onTap: () async => showDialog(
                            context: context,
                            builder: (context) => PopUpAction(
                                  borderColor: Colors.redAccent,
                                  text: "Are you sure want to Delete This Picture?",
                                  textBtn1: "Yes",
                                  textBtn2: "No",
                                  onPressAction1: () async {
                                    await Provider.of<MyBodyProvider>(context, listen: false)
                                        .deleteImage(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  onPressAction2: () {
                                    Navigator.pop(context);
                                  },
                                )),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Provider.of<MyBodyProvider>(context).photoDataSelected.day!,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: primarycolor, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        Provider.of<MyBodyProvider>(context).photoDataSelected.date!,
                        textScaleFactor: 1,
                        style: TextStyle(color: primarycolor, fontSize: 24),
                      ),
                      SizedBox(
                        height: 62,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
