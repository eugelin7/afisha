import 'dart:collection';
import 'package:afisha/=models=/filter_params.dart';
import 'package:afisha/app/logger.dart';
import 'package:afisha/data/i_afisha_api.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class FilterProvider extends ChangeNotifier {
  final IAfishaApi _api;

  FilterProvider({required IAfishaApi api})
      : _api = api,
        super();

  final _logger = GetIt.I<Logger>();

  List<String> _countries = [];
  List<String> _cities = [];
  String? _selectedCountry;
  String? _selectedCity;
  DateTime? _dateStart;
  DateTime? _dateEnd;

  UnmodifiableListView<String> get countries => UnmodifiableListView<String>(_countries);
  UnmodifiableListView<String> get cities => UnmodifiableListView<String>(_cities);
  String? get selectedCountry => _selectedCountry;
  String? get selectedCity => _selectedCity;
  DateTime? get dateStart => _dateStart;
  DateTime? get dateEnd => _dateEnd;

  //-----
  Future<void> getCountries() async {
    if (_countries.isNotEmpty) return;
    _logger.info('Loading countries...');
    final res = await _api.fetchCountries();
    if (res.success) {
      _logger.good('Countries list has been loaded from server');
      _countries = [...res.data!];
    }
    notifyListeners();
  }

  //-----
  void setSelectedCountry(String? country) {
    if (_selectedCountry == country) return;
    if ((country != null) && (!_countries.contains(country))) return;
    _selectedCountry = country;
    _selectedCity = null;
    _cities = [];
    notifyListeners();
    if (_selectedCountry == null) return;
    Future.delayed(const Duration(milliseconds: 50), () async {
      final res = await _api.fetchCities(country: _selectedCountry!);
      if (res.success) {
        _logger.good('Cities list of {$_selectedCountry} has been loaded from server');
        _cities = [...res.data!];
      }
      notifyListeners();
    });
  }

  //-----
  void setSelectedCity(String? city) {
    if (_selectedCity == city) return;
    if (city == null) {
      _selectedCity = null;
      notifyListeners();
      return;
    }
    if (!_cities.contains(city)) return;
    _selectedCity = city;
    notifyListeners();
  }

  //-----
  void setDates(DateTime dateStart, DateTime dateEnd) {
    _dateStart = dateStart;
    _dateEnd = dateEnd;
    _logger.good('dateStart = $_dateStart, dateEnd = $_dateEnd');
    notifyListeners();
  }

  //-----
  FilterParams? getFilterParams() {
    if ((_selectedCountry == null) &&
        (_selectedCity == null) &&
        (_dateStart == null) &&
        (_dateEnd == null)) return null;
    return FilterParams(
      country: _selectedCountry,
      city: _selectedCity,
      dateStart: _dateStart,
      dateEnd: _dateEnd,
    );
  }

  //-----
  void clearAllFields() {
    _selectedCountry = null;
    _cities = [];
    _selectedCity = null;
    _dateStart = null;
    _dateEnd = null;
    notifyListeners();
  }
}
