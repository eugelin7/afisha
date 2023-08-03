import 'package:geolocator/geolocator.dart';

abstract class ILocationService {
  Future<Position> determineLocation();

  Future<String> locationToString(Position location);
}
