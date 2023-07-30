import 'package:afisha/app/logger.dart';
import 'package:get_it/get_it.dart';

class ApiResponse<T> {
  bool success;
  T? data;
  int? errorCode;
  String? errorMessage;

  ApiResponse({required this.success, this.data, this.errorCode, this.errorMessage});

  factory ApiResponse.failure(int? errorCode, String? errorMessage) => ApiResponse(
        success: false,
        data: null,
        errorCode: errorCode,
        errorMessage: errorMessage,
      );

  factory ApiResponse.success(T Function() parseData) {
    try {
      return ApiResponse(success: true, data: parseData());
    } catch (e, st) {
      GetIt.I<Logger>().handle(e, st, '======= Parsing Error =======');
      rethrow;
    }
  }
}
