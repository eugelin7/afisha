import 'package:afisha/app/logger.dart';
import 'package:afisha/=models=/_utils.dart';
import 'package:get_it/get_it.dart';

class Price {
  final double minValue;
  final double value;
  final double maxValue;
  final String currency;

  Price({
    required this.minValue,
    required this.value,
    required this.maxValue,
    required this.currency,
  });

  //-----
  factory Price.fromJson(Map<String, dynamic> json) {
    try {
      return Price(
        minValue: double.tryParse(json['minValue'].toString()) ?? 0.0,
        value: double.tryParse(json['value'].toString()) ?? 0.0,
        maxValue: double.tryParse(json['maxValue'].toString()) ?? 0.0,
        currency: json['currency'] ?? '',
      );
    } catch (e, st) {
      GetIt.I<Logger>().handleFatal(e, st, '######### Price.fromJson error:\n${mapInfo(json)}');
      rethrow;
    }
  }
}
