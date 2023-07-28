import 'package:afisha/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//---
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//---

class App extends StatelessWidget {
  App({super.key});

  final _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: kAppRoutes,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Afisha',
      //theme: themeLight,
      // supportedLocales: const [
      //   Locale('ru'), // Russian
      //   Locale('en'), // English
      // ],
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      locale: const Locale('ru'),
      debugShowCheckedModeBanner: false,
    );
  }
}
