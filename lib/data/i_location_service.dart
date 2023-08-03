import 'package:afisha/=common=/classes/latlang.dart';

abstract class ILocationService {
  Future<LatLang> determineLocation();
}
