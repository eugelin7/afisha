import 'package:flutter/material.dart';

class MainScreenProvider extends ChangeNotifier {
  bool _isFilterSheetVisible = false;
  bool get isFilterSheetVisible => _isFilterSheetVisible;

  void setFilterSheetVisibility(bool value) {
    if (value == _isFilterSheetVisible) return;
    _isFilterSheetVisible = value;
    notifyListeners();
  }

  void toggleFilterSheetVisibility() {
    _isFilterSheetVisible = !_isFilterSheetVisible;
    notifyListeners();
  }
}
