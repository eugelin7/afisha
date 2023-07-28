import 'package:afisha/app/logger.dart';
import 'package:afisha/data/api_response.dart';
import 'package:afisha/data/impl/afisha_api.dart';
import 'package:afisha/=models=/event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton<Logger>(Logger());

  //---
  //Log errors
  FlutterError.onError = (d) => GetIt.I<Logger>().handle(d.exception, d.stack);
  PlatformDispatcher.instance.onError = (error, stack) {
    GetIt.I<Logger>().handle(error, stack);
    return true;
  };
  //---

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final afishaApi = AfishaApi();
              final ApiResponse<List<Event>> response = await afishaApi.fetchEvents();
              if (!response.success) {
                debugPrint('Response was not successful');
                debugPrint(response.errorCode.toString());
                debugPrint(response.errorMessage);
                return;
              }
              for (var event in response.data!) {
                debugPrint(event.id);
                debugPrint(event.title);
                debugPrint('--------------');
              }
            },
            child: const Text('Get events'),
          ),
        ),
      ),
    );
  }
}
