import 'package:afisha/app/logger.dart';
import 'package:afisha/app/utils.dart';
import 'package:get_it/get_it.dart';

class Location {
  final String country;
  final String city;
  final String address;

  Location({
    required this.country,
    required this.city,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return Location(
        country: json['country'] ?? '',
        city: json['city'] ?? '',
        address: json['address'] ?? '',
      );
    } catch (e, st) {
      GetIt.I<Logger>().handleFatal(e, st, '######### Location.fromJson error:\n${mapInfo(json)}');
      rethrow;
    }
  }
}
