import 'package:afisha/=common=/classes/api_response.dart';
import 'package:afisha/=models=/event.dart';

abstract class IAfishaApi {
  Future<ApiResponse<List<Event>>> fetchEvents();
}
