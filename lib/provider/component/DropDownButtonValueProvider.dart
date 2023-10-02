import 'package:flutter/material.dart';

class DropDownButtonValueProvider with ChangeNotifier {
  String _selectedValue = "Male";
  String get selectedValue => _selectedValue;
  set selectedValue(String selectedValue) {
    _selectedValue = selectedValue;
    notifyListeners();
  }

  List<String> items = ["Male", "Female"];

  void onSelected(String value) {
    _selectedValue = value;
    notifyListeners();
  }
}
