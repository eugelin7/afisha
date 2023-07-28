import 'package:afisha/data/api_response.dart';
import 'package:afisha/=models=/event.dart';

abstract class IAfishaApi {
  Future<ApiResponse<List<Event>>> fetchEvents();
}
