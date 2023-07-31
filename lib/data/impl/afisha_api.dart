import 'package:afisha/=common=/classes/api_response.dart';
import 'package:afisha/data/i_afisha_api.dart';
import 'package:afisha/data/impl/api_base.dart';
import 'package:afisha/=models=/event.dart';

class AfishaApi extends ApiBase implements IAfishaApi {
  //----
  @override
  Future<ApiResponse<List<Event>>> fetchEvents() async {
    final resp = await apiCall(ApiMethod.get, '/events');
    return responseToList<Event>(resp, (e) => Event.fromJson(e));
  }

  //----
  @override
  Future<ApiResponse<List<String>>> fetchCountries() async {
    final resp = await apiCall(ApiMethod.get, '/location/usedCountries');
    return responseToList<String>(resp, (e) => e.toString());
  }

  //----
  @override
  Future<ApiResponse<List<String>>> fetchCities({required String country}) async {
    final resp = await apiCall(ApiMethod.get, '/location/usedCities/$country');
    return responseToList<String>(resp, (e) => e.toString());
  }
  //----
}
