import 'package:afisha/=common=/classes/latlang.dart';
import 'package:afisha/=common=/classes/x_status.dart';
import 'package:afisha/app/logger.dart';
import 'package:afisha/data/i_geocoding_service.dart';
import 'package:afisha/data/i_location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class LocationProvider extends ChangeNotifier {
  final ILocationService _locationService;

  LocationProvider({required ILocationService locationService})
      : _locationService = locationService,
        super();

  final _logger = GetIt.I<Logger>();
  final _geocodingService = GetIt.I<IGeocodingService>();

  XStatus _locationStatus = XStatus.initial;
  LatLang? _location;
  String? _locationString;
  String? _errorMsg;

  XStatus get locationStatus => _locationStatus;
  //Position? get location => _location;
  String? get locationString => _locationString;
  String? get errorMsg => _errorMsg;

  Future<void> getCurrentLocation() async {
    _logger.good('Trying to determine location...');
    _locationStatus = XStatus.inProgress;
    _locationString = null;
    _errorMsg = null;
    notifyListeners();
    try {
      _location = await _locationService.determineLocation();
      _locationString = await _geocodingService.locationToString(_location!);
      _locationStatus = XStatus.success;
      _logger.good('Current location: $_locationString');
    } catch (e) {
      _errorMsg = e.toString();
      _locationStatus = XStatus.failure;
      _logger.warning('Location error: ${e.toString()}');
    }
    notifyListeners();
  }
}
