import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:free_workout_apps/StorageProvider.dart';
import 'package:free_workout_apps/model/WorkoutProgram.dart';
import 'package:free_workout_apps/page/dashboardpage/workoutpage/PrepareWorkoutPageView.dart';
import 'package:provider/provider.dart';

import '../../model/UserData.dart';
import '../../page/DashboardPageView.dart';
import '../../widget/BasicLoader.dart';

class WorkoutProvider extends ChangeNotifier {
  DatabaseReference database = FirebaseDatabase.instance.ref();

  int _restTime = 30;
  int get restTime => _restTime;
  set restTime(int restTime) {
    _restTime = restTime;
    notifyListeners();
  }

  WorkoutProgram _workoutData = WorkoutProgram();
  WorkoutProgram get workoutData => _workoutData;
  set workoutData(WorkoutProgram workoutData) {
    _workoutData = workoutData;
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

  int _workoutIndex = 0;
  int get workoutIndex => _workoutIndex;
  set workoutIndex(int workoutIndex) {
    _workoutIndex = workoutIndex;
    notifyListeners();
  }

  int _workoutIndexData = 0;
  int get workoutIndexData => _workoutIndexData;
  set workoutIndexData(int workoutIndexData) {
    _workoutIndexData = workoutIndexData;
    notifyListeners();
  }

  bool _isRest = false;
  bool get isRest => _isRest;
  set isRest(bool isRest) {
    _isRest = isRest;
    notifyListeners();
  }

  bool _isDone = false;
  bool get isDone => _isDone;
  set isDone(bool isDone) {
    _isDone = isDone;
    notifyListeners();
  }

  Timer? timer;

  void runbacktime() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      restTime--;
      if (restTime == 0) {
        isRest = false;
        restTime = 30;
        _.cancel();
      }
    });
    notifyListeners();
  }

  String formatTime() {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    Duration d = Duration(seconds: restTime);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }

  void nextWorkout() {
    if (workoutIndex != workoutData.level![levelIndex].workoutData!.length - 1) {
      workoutIndex += 1;
      isRest = true;
      runbacktime();
    } else {
      isDone = true;
      isRest = false;
    }
    notifyListeners();
  }

  void resetVariable() {
    restTime = 30;
    workoutIndex = 0;
    levelIndex = 0;
    isRest = false;
    isDone = false;
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    }
    notifyListeners();
  }

  Future finishedWorkout(context) async {
    showDialog(
      context: context,
      builder: (context) => BasicLoader(),
    );
    final id = await StorageProvider.getUserToken();
    final finishedWorkoutData = await database
        .child("userDatabase")
        .child(id!)
        .child("challangeData")
        .child("$workoutIndexData")
        .child(workoutData.level![levelIndex].title!)
        .get();
    await database
        .child("userDatabase")
        .child(id!)
        .child("challangeData")
        .child("$workoutIndexData")
        .child(workoutData.level![levelIndex].title!)
        .set(int.parse(finishedWorkoutData.value.toString()) + 1)
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPageView(),
          ),
          (route) => false);
      resetVariable();
    });
  }
}
