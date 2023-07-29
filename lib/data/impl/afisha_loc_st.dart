import 'package:afisha/=models=/event.dart';
import 'package:afisha/app/logger.dart';
import 'package:afisha/data/i_afisha_loc_st.dart';
import 'package:afisha/data/impl/hive_adapters/event_adapter.dart';
import 'package:afisha/data/impl/hive_adapters/location_adapter.dart';
import 'package:afisha/data/impl/hive_adapters/price_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AfishaLocSt implements IAfishaLocSt {
  static const eventsBoxName = 'events';
  static const favIdsBoxName = 'fav_ids';
  static const lastSavingBoxName = 'last_saving_date';

  late final Box<Event> _eventsBox;
  late final Box<String> _favIdsBox;
  late final Box<DateTime> _lastSavingDateBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(LocationAdapter());
    Hive.registerAdapter(PriceAdapter());
    Hive.registerAdapter(EventAdapter());

    _eventsBox = await Hive.openBox<Event>(eventsBoxName);
    _favIdsBox = await Hive.openBox<String>(favIdsBoxName);
    _lastSavingDateBox = await Hive.openBox<DateTime>(lastSavingBoxName);
  }

  @override
  Future<DateTime> get dateOfLastSaving {
    final dateTime = _lastSavingDateBox.get(0);
    if (dateTime == null) {/* GetIt.I<Logger>().error(exception); */}
    return Future.value(dateTime);
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    await _eventsBox.clear();
    for (var i = 0; i < events.length; i++) {
      await _eventsBox.put(i.toString().padLeft(15, '0'), events[i]);
    }
    await _lastSavingDateBox.put(0, DateTime.now());
    GetIt.I<Logger>().good('Events have been saved to local storage');
  }

  @override
  Future<List<Event>> loadEvents() {
    return Future.value(_eventsBox.values.toList());
  }

  @override
  Future<List<String>> loadFavIdList() {
    return Future.value(_favIdsBox.keys.map((e) => e.toString()).toList());
  }

  @override
  Future<void> saveToFavIdList(String eventId) async {
    await _favIdsBox.put(eventId, '');
  }

  @override
  Future<void> deleteFromFavIdList(String eventId) async {
    await _favIdsBox.delete(eventId);
  }
}
