import 'package:dio/dio.dart';

final kDioOptions = BaseOptions(
  baseUrl: 'https://api.poster-test-peredelano.orby-tech.space/api',
  responseType: ResponseType.json,
  connectTimeout: const Duration(seconds: 6),
  receiveTimeout: const Duration(seconds: 7),
  headers: {'content-Type': 'application/json'},
);
