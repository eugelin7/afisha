import 'package:afisha/data/i_location_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService implements ILocationService {
  //final _logger = GetIt.I<Logger>();

  @override
  Future<Position> determineLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('locationServicesAreDisabled'.tr());

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('locationPermissionsAreDenied'.tr());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('locationPermissionsArePermanentlyDenied'.tr());
    }

    // We have permission
    return await Geolocator.getCurrentPosition();
  }

  //-----
  @override
  Future<String> locationToString(Position location) async {
    final placemarksList = await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarksList.isNotEmpty) {
      final placemark = placemarksList.first;
      return '${placemark.country}'
          '${(placemark.locality == '') ? '' : ', ${placemark.locality}'}';
    }
    return 'locationNotFound'.tr();
  }
}
