import 'package:flutter/material.dart';

class PasswordPeekerProvider with ChangeNotifier {
  bool _isInvisible = true;
  bool get isInvisible => _isInvisible;
  set isInvisible(bool isInvisible) {
    _isInvisible = isInvisible;
    notifyListeners();
  }

  void onClick() {
    isInvisible = isInvisible == true ? false : true;
  }
}
