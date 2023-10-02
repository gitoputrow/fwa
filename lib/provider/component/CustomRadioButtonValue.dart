import 'package:flutter/material.dart';

class CustomRadioButtonValue with ChangeNotifier{
  String _sortProgram = "all type";
  String get sortProgram => _sortProgram;
  set sortProgram(String sortProgram) {
    _sortProgram = sortProgram;
    notifyListeners();
  }
}