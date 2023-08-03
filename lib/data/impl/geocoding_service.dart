import 'package:afisha/=common=/classes/latlang.dart';
import 'package:afisha/data/i_geocoding_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';

class GeocodingService implements IGeocodingService {
  @override
  Future<String> locationToString(LatLang location) async {
    final placemarksList = await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarksList.isNotEmpty) {
      final placemark = placemarksList.first;
      return '${placemark.country}'
          '${(placemark.locality == '') ? '' : ', ${placemark.locality}'}';
    }
    return 'locationNotFound'.tr();
  }

  @override
  Future<LatLang?> addressToLocation(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      return LatLang(locations.first.latitude, locations.first.longitude);
    }
    return null;
  }
}
