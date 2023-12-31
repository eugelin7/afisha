import 'dart:collection';
import 'package:afisha/=models=/event.dart';
import 'package:afisha/=models=/filter_params.dart';
import 'package:afisha/app/logger.dart';
import 'package:afisha/data/i_afisha_api.dart';
import 'package:afisha/data/i_afisha_loc_st.dart';
import 'package:afisha/=common=/classes/x_status.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppProvider extends ChangeNotifier {
  final IAfishaApi _api;
  final IAfishaLocSt _locSt;

  AppProvider({required IAfishaApi api, required IAfishaLocSt locSt})
      : _api = api,
        _locSt = locSt,
        super();

  final _logger = GetIt.I<Logger>();

  //---
  List<Event> _events = [];
  XStatus _eventsLoadingStatus = XStatus.initial;
  bool? _loadedFromServer;
  DateTime? _dateOfLastSaving;
  Set<String> _favEventIds = {};
  String _searchEventString = '';
  FilterParams? _filterParams;
  //---

  UnmodifiableListView<Event> get allEvents => UnmodifiableListView(_events);

  //-----
  // События (с учётом фильтра и поиска)
  UnmodifiableListView<Event> get events {
    if ((_searchEventString.trim().isEmpty) && (filterParams == null)) {
      return UnmodifiableListView(_events);
    }
    // Применяем фильтр
    List<Event> events = [];
    if (filterParams == null) {
      events = _events;
    } else {
      events = _events.where((e) {
        bool countryMatch = true;
        if (filterParams!.country != null) {
          countryMatch = (e.location.country == filterParams!.country);
        }
        bool cityMatch = true;
        if (filterParams!.city != null) {
          cityMatch = (e.location.city == filterParams!.city);
        }
        bool datesMatch = true;
        if ((filterParams!.dateStart != null) &&
            (filterParams!.dateEnd != null) &&
            (e.date != null)) {
          datesMatch =
              e.date!.isAfter(filterParams!.dateStart!) && e.date!.isBefore(filterParams!.dateEnd!);
        }
        return countryMatch && cityMatch && datesMatch;
      }).toList();
    }
    // Применяем поиск (по отфильтрованным данным)
    if (_searchEventString.trim().isEmpty) return UnmodifiableListView(events);
    return UnmodifiableListView(events
        .where((el) => el.title.toLowerCase().contains(_searchEventString.trim().toLowerCase()))
        .toList());
  }

  //-----
  // События в "Избранном"
  UnmodifiableListView<Event> get favEvents =>
      UnmodifiableListView(_events.where((el) => _favEventIds.contains(el.id)).toList());
  //-----

  XStatus get eventsLoadingStatus => _eventsLoadingStatus;
  bool? get loadedFromServer => _loadedFromServer;
  DateTime? get dateOfLastSaving => _dateOfLastSaving;
  Set<String> get favEventIds => _favEventIds;
  String get searchEventString => _searchEventString;
  FilterParams? get filterParams => _filterParams;

  //-----
  // Получаем список событий (или с сервера или из лок.хранилища)
  void getAllEvents() async {
    _logger.info('Loading events...');
    _eventsLoadingStatus = XStatus.inProgress;
    _loadedFromServer = null;
    notifyListeners();
    final res = await _api.fetchEvents();
    if (res.success) {
      _logger.good('Events have been loaded from server');
      _events = [...res.data!];
      _loadedFromServer = true;
      _locSt.saveEvents(_events);
      _eventsLoadingStatus = XStatus.success;
    } else {
      _logger.warning('Error while loading from server.');
      _logger.info('Loading from Local Storage...');
      _events = [...await _locSt.loadEvents()];
      _dateOfLastSaving = await _locSt.dateOfLastSaving;
      _loadedFromServer = false;
      _eventsLoadingStatus = XStatus.success;
      _logger.good('Success. Date of last saving: $_dateOfLastSaving');
    }
    _favEventIds = (await _locSt.loadFavIdList()).toSet();
    notifyListeners();
  }

  //-----
  void addEventToFavList(String eventId) async {
    _favEventIds.add(eventId);
    await _locSt.saveToFavIdList(eventId);
    _logger.good('Event Id $eventId saved to favorites');
    notifyListeners();
  }

  void deleteEventFromFavList(String eventId) async {
    _favEventIds.remove(eventId);
    await _locSt.deleteFromFavIdList(eventId);
    _logger.good('Event Id $eventId removed from favorites');
    notifyListeners();
  }

  //-----
  void setSearchEventString(String newSearchString) {
    if (_searchEventString.trim().toLowerCase() == newSearchString.trim().toLowerCase()) return;
    _searchEventString = newSearchString.trim().toLowerCase();
    _logger.good('Search string: $_searchEventString  |  Found: ${events.length} events');
    notifyListeners();
  }

  //-----
  void setFilterParams(FilterParams? filterParams) {
    // TODO: if equal() then return
    _filterParams = filterParams;
    _logger
        .info('Filter params: country = ${_filterParams?.country}, city = ${_filterParams?.city},\n'
            'dateStart = ${_filterParams?.dateStart}, dateEnd = ${_filterParams?.dateEnd}');
    notifyListeners();
  }
  //-----
}
