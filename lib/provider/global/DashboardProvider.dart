import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/StorageProvider.dart';
import 'package:free_workout_apps/model/CalisthenicPark.dart';
import 'package:free_workout_apps/model/WorkoutProgram.dart';
import 'package:free_workout_apps/page/HomeScreenPageView.dart';
import 'package:free_workout_apps/page/dashboardpage/HomePageView.dart';
import 'package:free_workout_apps/page/dashboardpage/ParkPageView.dart';
import 'package:free_workout_apps/page/dashboardpage/ProfilePageView.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/UserData.dart';
import '../../widget/BasicLoader.dart';

class DashboardProvider with ChangeNotifier {
  DatabaseReference database = FirebaseDatabase().ref();
  final storageRef = FirebaseStorage.instance.ref();

  List<WorkoutProgram> _workoutProgram = <WorkoutProgram>[];
  List<WorkoutProgram> get workoutProgram => _workoutProgram;
  set workoutProgram(List<WorkoutProgram> workoutProgram) {
    _workoutProgram = workoutProgram;
    notifyListeners();
  }

  List<WorkoutProgram> _workoutProgramTemp = <WorkoutProgram>[];
  List<WorkoutProgram> get workoutProgramTemp => _workoutProgramTemp;
  set workoutProgramTemp(List<WorkoutProgram> workoutProgramTemp) {
    _workoutProgramTemp = workoutProgramTemp;
    notifyListeners();
  }

  List<CalisthenicPark> _calisthenicPark = <CalisthenicPark>[];
  List<CalisthenicPark> get calisthenicPark => _calisthenicPark;
  set calisthenicPark(List<CalisthenicPark> calisthenicPark) {
    _calisthenicPark = calisthenicPark;
    notifyListeners();
  }

  List<String> workoutList = <String>[];

  List<Widget> pages = <Widget>[HomePageView(), ParkPageView(), ProfilePageView()];

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  UserData _userData = UserData();
  UserData get userData => _userData;
  set userData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  int _levelIndex = 0;
  int get levelIndex => _levelIndex;
  set levelIndex(int levelIndex) {
    _levelIndex = levelIndex;
    notifyListeners();
  }

  PageController _pageController = PageController(viewportFraction: 0.91);
  PageController get pageController => _pageController;
  set pageController(PageController pageController) {
    _pageController = pageController;
    notifyListeners();
  }

  bool _startPage = false;
  bool get startPage => _startPage;
  set startPage(bool startPage) {
    _startPage = startPage;
    notifyListeners();
  }

  String _sortPark = "distance";
  String get sortPark => _sortPark;
  set sortPark(String sortPark) {
    _sortPark = sortPark;
    notifyListeners();
  }

  String _sortProgram = "all type";
  String get sortProgram => _sortProgram;
  set sortProgram(String sortProgram) {
    _sortProgram = sortProgram;
    notifyListeners();
  }

  String _workoutSelected = "";
  String get workoutSelected => _workoutSelected;
  set workoutSelected(String workoutSelected) {
    _workoutSelected = workoutSelected;
    notifyListeners();
  }

  LatLng _userCoordinate = LatLng(0, 0);
  LatLng get userCoordinate => _userCoordinate;
  set userCoordinate(LatLng userCoordinate) {
    _userCoordinate = userCoordinate;
    notifyListeners();
  }

  void sortingProgram(String value) {
    sortProgram = value;
    workoutProgramTemp.clear();
    workoutProgramTemp.addAll(workoutProgram);
    if (value != "all type") {
      workoutProgramTemp.removeWhere((element) {
        return element.type != value;
      });
      print(workoutProgram.length);
    }
    notifyListeners();
  }

  void changePage(int index) {
    currentPage = index;
  }

  void sortingCalisthenicPark(String selected, context) {
    sortPark = selected;
    if (sortPark == "distance") {
      calisthenicPark.sort(
        (a, b) => a.distance!.compareTo(b.distance!),
      );
    } else {
      calisthenicPark.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );
    }
    Navigator.pop(context);
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

  Future getWorkoutProgram() async {
    try {
      final data = await database.child("DataWorkout").child("data").get();

      List jsonData = json.decode(json.encode(data.value).toString());

      workoutProgram =
          List<WorkoutProgram>.from(jsonData.map((item) => WorkoutProgram.fromJson(item)));

      for (var items in workoutProgram) {
        for (var levels in items.level!) {
          print(levels.title);

          int repSum = levels.title == "easy"
              ? userData
                  .challangeData![
                      userData.challangeData!.indexWhere((element) => element.title == items.name)]
                  .easy!
              : userData
                  .challangeData![
                      userData.challangeData!.indexWhere((element) => element.title == items.name)]
                  .hard!;
          levels.reps = levels.reps! + (2 * repSum);
        }
      }

      workoutProgramTemp =
          List<WorkoutProgram>.from(jsonData.map((item) => WorkoutProgram.fromJson(item)));

      for (var items in workoutProgramTemp) {
        for (var levels in items.level!) {
          print(levels.title);

          int repSum = levels.title == "easy"
              ? userData
                  .challangeData![
                      userData.challangeData!.indexWhere((element) => element.title == items.name)]
                  .easy!
              : userData
                  .challangeData![
                      userData.challangeData!.indexWhere((element) => element.title == items.name)]
                  .hard!;
          levels.reps = levels.reps! + (2 * repSum);
        }
      }

      workoutSelected = workoutProgram[0].name!;
      workoutList.clear();
      workoutProgram.forEach((element) {
        workoutList.add(element.name!);
      });
    } catch (e) {
      print(e);
    }
    // notifyListeners();
    print(startPage);
  }

  Future getUserCoordinate() async {
    bool _isServiceEnabled;
    LocationPermission _locationPermission;

    //check service location
    _isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isServiceEnabled) {
      return;
    }

    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied ||
        _locationPermission == LocationPermission.deniedForever) {
      return;
    }

    return await Geolocator.getCurrentPosition().then((currLocation) async {
      //await placeUserMarker(currLocation.latitude, currLocation.longitude);
      userCoordinate = LatLng(currLocation.latitude, currLocation.longitude);
      print(userCoordinate);
      // locPermission = true;
    });
  }

  Future logout(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => BasicLoader(),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreenPageView(),
          ),
          (route) => false);
      await StorageProvider.removeUserToken();
    } catch (e) {}
  }

  Future getCalisthenicPark() async {
    try {
      calisthenicPark.clear();
      await getUserCoordinate();
      final data = await database.child("DataPark").get();
      List jsonData = json.decode(json.encode(data.value).toString());
      calisthenicPark =
          List<CalisthenicPark>.from(jsonData.map((item) => CalisthenicPark.fromJson(item)));
      for (var items in calisthenicPark) {
        items.distance = Geolocator.distanceBetween(userCoordinate.latitude,
                userCoordinate.longitude, items.latitude!, items.longitude!) /
            1000;
      }
      calisthenicPark.sort(
        (a, b) => a.distance!.compareTo(b.distance!),
      );
    } catch (e) {
      print(e);
    }
  }

  Future deleteAccount(context) async {
    showDialog(
      context: context,
      builder: (context) => BasicLoader(),
    );
    final token = await StorageProvider.getUserToken();
    await storageRef.child("$token").listAll().then((value) {
      value.items.forEach((element) async {
        await storageRef.child(element.fullPath).delete();
      });
    }).whenComplete(() async => await database.child("userDatabase").child(token.toString()).remove());
   
    await StorageProvider.removeUserToken();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreenPageView(),
        ),
        (route) => false);
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
        await getWorkoutProgram();
        await getCalisthenicPark();
        startPage = true;
      }
    } catch (e) {}
  }
}
