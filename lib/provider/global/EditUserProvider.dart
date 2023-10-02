import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free_workout_apps/StorageProvider.dart';
import 'package:free_workout_apps/model/CalisthenicPark.dart';
import 'package:free_workout_apps/model/WorkoutProgram.dart';
import 'package:free_workout_apps/page/HomeScreenPageView.dart';
import 'package:free_workout_apps/page/dashboardpage/HomePageView.dart';
import 'package:free_workout_apps/page/dashboardpage/ParkPageView.dart';
import 'package:free_workout_apps/page/dashboardpage/ProfilePageView.dart';
import 'package:free_workout_apps/widget/ToastMessageCustom.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/UserData.dart';
import '../../page/DashboardPageView.dart';
import '../../widget/BasicLoader.dart';

class EditUserProvider with ChangeNotifier {
  DatabaseReference database = FirebaseDatabase().ref();
  final storageRef = FirebaseStorage.instance.ref();

  UserData _userData = UserData();
  UserData get userData => _userData;
  set userData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  bool _startPage = false;
  bool get startPage => _startPage;
  set startPage(bool startPage) {
    _startPage = startPage;
    notifyListeners();
  }

  TextEditingController _etFullName = TextEditingController();
  TextEditingController get etFullName => _etFullName;
  set etFullName(TextEditingController etFullName) {
    _etFullName = etFullName;
    notifyListeners();
  }

  TextEditingController _etUserName = TextEditingController();
  TextEditingController get etUserName => _etUserName;
  set etUserName(TextEditingController etUserName) {
    _etUserName = etUserName;
    notifyListeners();
  }

  TextEditingController _etOldPass = TextEditingController();
  TextEditingController get etOldPass => _etOldPass;
  set etOldPass(TextEditingController etOldPass) {
    _etOldPass = etOldPass;
    notifyListeners();
  }

  TextEditingController _etNewPass = TextEditingController();
  TextEditingController get etNewPass => _etNewPass;
  set etNewPass(TextEditingController etNewPass) {
    _etNewPass = etNewPass;
    notifyListeners();
  }

  TextEditingController _etWeight = TextEditingController();
  TextEditingController get etWeight => _etWeight;
  set etWeight(TextEditingController etWeight) {
    _etWeight = etWeight;
    notifyListeners();
  }

  TextEditingController _etHeight = TextEditingController();
  TextEditingController get etHeight => _etHeight;
  set etHeight(TextEditingController etHeight) {
    _etHeight = etHeight;
    notifyListeners();
  }

  String _selectedValue = "Male";
  String get selectedValue => _selectedValue;
  set selectedValue(String selectedValue) {
    _selectedValue = selectedValue;
    notifyListeners();
  }

  bool _isInvisibleOldPass = true;
  bool get isInvisibleOldPass => _isInvisibleOldPass;
  set isInvisibleOldPass(bool isInvisibleOldPass) {
    _isInvisibleOldPass = isInvisibleOldPass;
    notifyListeners();
  }

  bool _isInvisibleNewPass = true;
  bool get isInvisibleNewPass => _isInvisibleNewPass;
  set isInvisibleNewPass(bool isInvisibleNewPass) {
    _isInvisibleNewPass = isInvisibleNewPass;
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

  List<String> items = ["Male", "Female"];

  void onSelected(String value) {
    _selectedValue = value;
    notifyListeners();
  }

  Future getUserData(context) async {
    try {
      final token = await StorageProvider.getUserToken();
      final data = await database.child("userDatabase").child(token.toString()).get();
      userData = UserData.fromJson(json.decode(json.encode(data.value)));
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

  Future updateProfile(context) async {
    if (etFullName.text.isEmpty &&
        etHeight.text.isEmpty &&
        etWeight.text.isEmpty &&
        imageSource == null) {
      ToastMessageCustom.ToastMessage("Please Fill any information", Colors.red, context);
    } else {
      showDialog(
        context: context,
        builder: (context) => BasicLoader(),
      );
      if (imageSource != null) {
        await uploadImage();
      }
      final id = await StorageProvider.getUserToken();
      await database.child("userDatabase").child("$id").child("gender").set(selectedValue);
      await database
          .child("userDatabase")
          .child("$id")
          .child("name")
          .set(etFullName.text.isEmpty ? userData.name : etFullName.text);
      await database
          .child("userDatabase")
          .child("$id")
          .child("height")
          .set(etHeight.text.isEmpty ? userData.height : etHeight.text);
      await database
          .child("userDatabase")
          .child("$id")
          .child("weight")
          .set(etWeight.text.isEmpty ? userData.weight : etWeight.text);
      ToastMessageCustom.ToastMessage("Profile Updated", Colors.green, context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPageView(
              currentPage: 2,
            ),
          ),
          (route) => false);
    }
  }

  bool updateAccountFailed = true;

  Future changeUsername(context) async {
    updateAccountFailed = false;
    if (etUserName.text.isNotEmpty) {
      final data = await database.child("userDatabase").get();
      final id = await StorageProvider.getUserToken();
      for (var children in data.children) {
        if (etUserName.text == children.child("username").value.toString()) {
          Navigator.pop(context);
          ToastMessageCustom.ToastMessage("Username already in used", Colors.red, context);
          updateAccountFailed = true;
          return;
        }
      }
      await database.child("userDatabase").child("$id").child("username").set(etUserName.text);
    }
  }

  Future changePassword(context) async {
    updateAccountFailed = false;
    if (etOldPass.text.isNotEmpty || etNewPass.text.isNotEmpty) {
      if (etOldPass.text == userData.pass) {
        if (etOldPass.text != etNewPass.text) {
          final id = await StorageProvider.getUserToken();
          await database.child("userDatabase").child("$id").child("pass").set(etNewPass.text);
        } else {
          updateAccountFailed = true;
          Navigator.pop(context);
          ToastMessageCustom.ToastMessage("Password cannot be same", Colors.red, context);
        }
      } else {
        updateAccountFailed = true;
        Navigator.pop(context);
        ToastMessageCustom.ToastMessage("Wrong Password", Colors.red, context);
      }
    }
  }

  Future updateAccount(context) async {
    if (etUserName.text.isEmpty && etOldPass.text.isEmpty && etNewPass.text.isEmpty) {
      ToastMessageCustom.ToastMessage("Please Fill any information", Colors.red, context);
    } else {
      showDialog(
        context: context,
        builder: (context) => BasicLoader(),
      );
      await changeUsername(context);
      await changePassword(context);
      if (updateAccountFailed == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPageView(
                currentPage: 2,
              ),
            ),
            (route) => false);
      }
    }
  }

  Future PickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? imageTemporary = File(image.path);
      imageSource = imageTemporary;
      imagepath = imageTemporary.path;
    } on PlatformException catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future uploadImage() async {
    try {
      final userid = await StorageProvider.getUserToken();
      await storageRef.child(userid!).child("pp$userid").putFile(imageSource!).whenComplete(
          () async => await storageRef
                  .child(userid)
                  .child("pp$userid")
                  .getDownloadURL()
                  .then((value) async {
                await database.child("userDatabase").child(userid).child("photoprofile").set(value);
              }));
    } catch (e) {}
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
