import 'package:talker_flutter/talker_flutter.dart';

class Logger {
  late final Talker _talker;

  Logger() {
    _talker = TalkerFlutter.init();
    _talker.good('Logger started');
  }

  void handle(Object exception, [StackTrace? stack, String? msg]) {
    // TODO: FirebaseCrashlytics.instance.recordError(exception, stack, fatal = false);
    _talker.handle(exception, stack, msg);
  }

  void handleFatal(Object exception, [StackTrace? stack, String? msg]) {
    // TODO: FirebaseCrashlytics.instance.recordError(exception, stack, fatal = true);
    _talker.handle(exception, stack, msg);
  }

  void warning(String msg) {
    _talker.warning(msg);
  }

  void info(String msg) {
    _talker.info(msg);
  }

  void good(String msg) {
    _talker.good(msg);
  }
}
