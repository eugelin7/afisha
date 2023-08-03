import 'package:afisha/=common=/classes/latlang.dart';

abstract class IGeocodingService {
  Future<String> locationToString(LatLang location);
  Future<LatLang?> addressToLocation(String address);
}
