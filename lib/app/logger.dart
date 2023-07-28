import 'package:talker_flutter/talker_flutter.dart';

class Logger {
  late final Talker _talker;

  Logger() {
    _talker = TalkerFlutter.init();
    _talker.good('Logger started');
  }

  void handle(Object exception, [StackTrace? stack, String? msg]) {
    //FirebaseCrashlytics.instance.recordError(exception, stack, fatal = false);
    _talker.handle(exception, stack, msg);
  }

  void handleFatal(Object exception, [StackTrace? stack, String? msg]) {
    //FirebaseCrashlytics.instance.recordError(exception, stack, fatal = true);
    _talker.handle(exception, stack, msg);
  }
}
