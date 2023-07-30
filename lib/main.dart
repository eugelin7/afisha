import 'package:afisha/app/app.dart';
import 'package:afisha/app/logger.dart';
import 'package:afisha/data/impl/afisha_api.dart';
import 'package:afisha/data/impl/afisha_loc_st.dart';
import 'package:afisha/logic/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  //---
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  //---
  GetIt.I.registerSingleton<Logger>(Logger());

  //---
  //Log errors
  FlutterError.onError = (d) => GetIt.I<Logger>().handle(d.exception, d.stack);
  PlatformDispatcher.instance.onError = (error, stack) {
    GetIt.I<Logger>().handle(error, stack);
    return true;
  };

  //---
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //---
  final afishaApi = AfishaApi();
  final afishaLocSt = AfishaLocSt();

  await afishaLocSt.init();

  //---
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(
            api: afishaApi,
            locSt: afishaLocSt,
          )..getAllEvents(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru'),
        child: App(),
      ),
    ),
  );
}
