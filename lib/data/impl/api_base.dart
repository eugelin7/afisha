import 'package:afisha/app/logger.dart';
import 'package:afisha/=common=/classes/api_response.dart';
import 'package:afisha/data/impl/dio_options.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

enum ApiMethod { get /* post , put, patch, delete*/ }

abstract class ApiBase {
  late final Dio _dio;

  ApiBase() {
    _dio = Dio(kDioOptions);
  }

  //--------

  Future<ApiResponse<dynamic>> apiCall(
    ApiMethod method,
    String endPoint, {
    Map<String, dynamic>? params,
  }) async {
    final result = ApiResponse<dynamic>(success: false);
    try {
      Response<dynamic> response;
      switch (method) {
        case ApiMethod.get:
          response = await _dio.get(endPoint);
          break;
        // case ApiMethod.post:
        //   response = await _dio.post(endPoint);
        //   break;
      }
      result.success = true;
      result.data = response.data;
    } on DioException catch (e, st) {
      GetIt.I<Logger>().handle(e, st, '======= Dio Exception =======');
      result.errorCode = e.response?.statusCode;
      result.errorMessage = e.error.toString();
    } catch (e, st) {
      GetIt.I<Logger>().handle(e, st, 'Unexpected error');
      result.errorCode = 0;
      result.errorMessage = 'Unexpected error';
    }
    return result;
  }

  //----
  ApiResponse<List<T>> responseToList<T>(ApiResponse<dynamic> resp, T Function(dynamic) fromJson) {
    return (resp.success)
        ? ApiResponse<List<T>>.success(
            () => (resp.data as List<dynamic>).map((el) => fromJson(el)).toList(),
          )
        : ApiResponse<List<T>>.failure(resp.errorCode, resp.errorMessage);
  }

  //----
  ApiResponse<T> responseTo<T>(ApiResponse<dynamic> resp, T Function(dynamic) fromJson) {
    return (resp.success)
        ? ApiResponse<T>.success(() => fromJson(resp.data))
        : ApiResponse<T>.failure(resp.errorCode, resp.errorMessage);
  }
}
