import 'dart:collection';
import 'package:afisha/=models=/event.dart';
import 'package:afisha/data/i_afisha_api.dart';
import 'package:afisha/logic/x_status.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  final IAfishaApi _api;

  AppProvider({required IAfishaApi api})
      : _api = api,
        super();

  //---
  List<Event> _events = [];
  XStatus _eventsLoadingStatus = XStatus.initial;
  String _eventsLoadingErrorMsg = '';
  String _searchEventString = '';
  //---

  UnmodifiableListView<Event> get allEvents => UnmodifiableListView(_events);
  UnmodifiableListView<Event> get events {
    if (_searchEventString.trim().isEmpty) return UnmodifiableListView(_events);
    return UnmodifiableListView(_events
        .where((el) => el.title.toLowerCase().contains(_searchEventString.trim().toLowerCase()))
        .toList());
  }

  XStatus get eventsLoadingStatus => _eventsLoadingStatus;
  String get eventsLoadingErrorMsg => _eventsLoadingErrorMsg;
  String get searchEventString => _searchEventString;

  //-----
  void getAllEvents() async {
    _eventsLoadingStatus = XStatus.inProgress;
    _eventsLoadingErrorMsg = '';
    notifyListeners();
    final res = await _api.fetchEvents();
    if (res.success) {
      _events = [...res.data!];
      _eventsLoadingStatus = XStatus.success;
    } else {
      _events = [];
      _eventsLoadingStatus = XStatus.failure;
      _eventsLoadingErrorMsg = (res.errorCode == null)
          ? res.errorMessage ?? 'Error'
          : 'Error code: ${res.errorCode}\n${res.errorMessage ?? ''}';
    }
    notifyListeners();
  }

  //-----
  void setSearchEventString(String newSearchString) {
    if (_searchEventString.trim().toLowerCase() == newSearchString.trim().toLowerCase()) return;
    _searchEventString = newSearchString.trim().toLowerCase();
    notifyListeners();
  }
}
