import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_workout_apps/page/HomeScreenPageView.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../StorageProvider.dart';
import '../../model/PhotoData.dart';
import '../../model/UserData.dart';
import '../../page/dashboardpage/HomePageView.dart';
import '../../widget/BasicLoader.dart';

class MyBodyProvider with ChangeNotifier {
  DatabaseReference database = FirebaseDatabase().ref();
  final storageRef = FirebaseStorage.instance.ref();

  UserData _userData = UserData();
  UserData get userData => _userData;
  set userData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  PhotoData _photoDataSelected = PhotoData();
  PhotoData get photoDataSelected => _photoDataSelected;
  set photoDataSelected(PhotoData photoDataSelected) {
    _photoDataSelected = photoDataSelected;
    notifyListeners();
  }

  bool _startPage = false;
  bool get startPage => _startPage;
  set startPage(bool startPage) {
    _startPage = startPage;
    notifyListeners();
  }

  String _imagepath = "";
  String get imagepath => _imagepath;
  set imagepath(String imagepath) {
    _imagepath = imagepath;
    notifyListeners();
  }

  File? _imageSource = null as File?;
  File? get imageSource => _imageSource;
  set imageSource(File? imageSource) {
    _imageSource = imageSource;
    notifyListeners();
  }

  List<PhotoData> _photoData = <PhotoData>[];
  List<PhotoData> get photoData => _photoData;
  set photoData(List<PhotoData> photoData) {
    _photoData = photoData;
    notifyListeners();
  }

  Future getUserData(context) async {
    try {
      final token = await StorageProvider.getUserToken();
      final data = await database.child("userDatabase").child(token.toString()).get();
      userData = UserData.fromJson(json.decode(json.encode(data.value)));
      photoData.clear();
      if (data.child("photo").exists) {
        for (var i in data.child("photo").children) {
          photoData.add(PhotoData.fromJson(json.decode(json.encode(i.value))));
        }
        photoData.sort(
          (b, a) => a.time!.compareTo(b.time!),
        );
      }
      print(photoData.length);
      print(userData.photoprofile == "null");
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreenPageView(),
          ),
          (route) => false);
    }
  }

  Future PickImage(ImageSource source, context) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image == null) {
        return;
      } else {
        File? imageTemporary = File(image.path);
        imageSource = imageTemporary;
        imagepath = imageTemporary.path;
        await uploadImage(context);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future uploadImage(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => BasicLoader(),
      );
      final userid = await StorageProvider.getUserToken();
      final time = DateFormat('yyyy-M-d H:mm:ss').format(DateTime.now());
      final date = DateFormat('MM - dd - y').format(DateTime.now());
      final day = DateFormat('EEEE').format(DateTime.now());
      final idPic = "photo_$time";
      await storageRef.child(userid!).child(idPic).putFile(imageSource!).whenComplete(() async =>
          await storageRef.child(userid).child(idPic).getDownloadURL().then((value) async {
            await database
                .child("userDatabase")
                .child(userid)
                .child("photo")
                .child(idPic)
                .set({"photo_url": value, "time": time, "date": date, "day": day, "id": idPic});
          }));
      await onInit(context);
      Navigator.pop(context, true);
    } catch (e) {
      print(e);
      Navigator.pop(context, true);
    }
    notifyListeners();
  }

  Future deleteImage(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => BasicLoader(),
      );
      final userid = await StorageProvider.getUserToken();
      await storageRef.child(userid!).child(photoDataSelected.id!).delete().whenComplete(
        () async {
          await database
              .child("userDatabase")
              .child(userid)
              .child("photo")
              .child(photoDataSelected.id!)
              .remove();
        },
      );
      await onInit(context);
      // Navigator.pop(context, true);
    } catch (e) {
      print(e);
      // Navigator.pop(context, true);
    }
    notifyListeners();
  }

  Future onInit(context) async {
    try {
      final token = await StorageProvider.getUserToken();
      if (token == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreenPageView(),
            ),
            (route) => false);
      } else {
        startPage = false;
        await getUserData(context);
        startPage = true;
      }
    } catch (e) {}
  }
}
