import 'package:flutter/material.dart';
// import 'package:theme_extensions/app_colors_extension.dart';
// import 'package:theme_extensions/app_text_theme_extension.dart';
// import 'package:theme_extensions/app_typography.dart';

class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  //----------------------------------------------
  // Light theme
  static final light = () {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        //seedColor: const Color(0xff48C78E),
        seedColor: const Color(0xff21A86B),
      ).copyWith(
        //primary: const Color(0xff48C78E),
        primary: const Color(0xff21A86B),
        primaryContainer: const Color(0xff21A86B),
        secondaryContainer: const Color(0xffDBDBDB),
        surfaceVariant: Colors.white,
        error: Colors.red.shade800,
        onError: Colors.white,
        errorContainer: Colors.red.shade800,
        onErrorContainer: Colors.white,
      ),
      useMaterial3: false,
    ).copyWith(
      focusColor: const Color(0xff21A86B),
      disabledColor: const Color(0xff48C78E),
      dividerColor: const Color(0xffC3C3C3),
    );
  }();

  //----------------------------------------------
  // Dark theme
  static final dark = () {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: false,
    );
  }();
}

//=================================================================
// A more convenient way to get `ThemeData` from the `BuildContext`.
// Usage example: `context.theme`.
extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}
