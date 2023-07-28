import 'package:afisha/data/api_response.dart';
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
}
