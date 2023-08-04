import 'package:flutter/material.dart';

class MainScreenProvider extends ChangeNotifier {
  //-------------
  // Filter Sheet visibility
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

  //-------------
  // Location Bar visibility
  bool _isLocationBarVisible = false;
  bool get isLocationBarVisible => _isLocationBarVisible;

  void setLocationBarVisibility(bool value) {
    if (value == _isLocationBarVisible) return;
    _isLocationBarVisible = value;
    notifyListeners();
  }
}
