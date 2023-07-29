import 'package:afisha/=models=/event.dart';

// Local Storage
abstract class IAfishaLocSt {
  Future<void> init();

  Future<DateTime?> get dateOfLastSaving;

  Future<List<Event>> loadEvents();
  Future<void> saveEvents(List<Event> events);

  Future<List<String>> loadFavIdList();
  Future<void> saveToFavIdList(String eventId);
  Future<void> deleteFromFavIdList(String eventId);
}
