import 'package:afisha/app/logger.dart';
import 'package:afisha/app/utils.dart';
import 'package:afisha/=models=/location.dart';
import 'package:afisha/=models=/price.dart';
import 'package:get_it/get_it.dart';

class Event {
  final String id;
  final String creatorId;
  final String title;
  final String description;
  final DateTime? date;
  final int durationInSeconds;
  final String? image;
  final Location location;
  final Price? price;
  final String url;

  Event({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    required this.date,
    required this.durationInSeconds,
    required this.image,
    required this.location,
    required this.price,
    required this.url,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    try {
      return Event(
        id: json['id'],
        creatorId: json['creatorId'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        //date: DateTime.tryParse(json['date'].toString()),
        date: DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        durationInSeconds: int.tryParse(json['durationInSeconds'].toString()) ?? 0,
        image: json['image'],
        location: Location.fromJson(json['location']),
        price: json['price'] == null ? null : Price.fromJson(json['price']),
        url: json['url'] ?? '',
      );
    } catch (e, st) {
      GetIt.I<Logger>().handleFatal(e, st, '######### Event.fromJson error:\n${mapInfo(json)}');
      rethrow;
    }
  }
}
