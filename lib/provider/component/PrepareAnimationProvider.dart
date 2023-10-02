import 'dart:async';

import 'package:flutter/material.dart';

import '../../page/dashboardpage/workoutpage/WorkoutListPageView.dart';

class PrepareAnimationProvider with ChangeNotifier {
  bool _isCountDown = false;
  bool get isCountDown => _isCountDown;
  set isCountDown(bool isCountDown) {
    _isCountDown = isCountDown;
    notifyListeners();
  }

  bool _isStartCountDown = true;
  bool get isStartCountDown => _isStartCountDown;
  set isStartCountDown(bool isStartCountDown) {
    _isStartCountDown = isStartCountDown;
    notifyListeners();
  }

  double _scaleText = 3;
  double get scaleText => _scaleText;
  set scaleText(double scaleText) {
    _scaleText = scaleText;
    notifyListeners();
  }

  int _countDown = 4;
  int get countDown => _countDown;
  set countDown(int countDown) {
    _countDown = countDown;
    notifyListeners();
  }

  double _opacityText = 0;
  double get opacityText => _opacityText;
  set opacityText(double opacityText) {
    _opacityText = opacityText;
    notifyListeners();
  }

  bool _isDone = false;
  bool get isDone => _isDone;
  set isDone(bool isDone) {
    _isDone = isDone;
    notifyListeners();
  }

  void startCountDown(context) {
    if (countDown == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutListPageView(),
          ));
    } else {
      countDown -= 1;
      scaleText = 3;
      opacityText = 1;
      Timer(Duration(milliseconds: 600), () {
        opacityText = 0;
        Timer(Duration(milliseconds: 600), () {
          scaleText = 8;
          Timer(Duration(milliseconds: 600), () {
            startCountDown(context);
          });
        });
      });
    }
  }

  void startAnimation(context) {
    Timer(Duration(milliseconds: 500), () {
      scaleText = 1;
      opacityText = 1;
      Timer(Duration(milliseconds: 2400), () {
        opacityText = 0;
        Timer(Duration(milliseconds: 1000), () {
          isCountDown = true;
          scaleText = 8;
          Timer(Duration(milliseconds: 600), () {
            startCountDown(context);
          });
        });
      });
    });
  }
}
