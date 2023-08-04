// ignore_for_file: use_build_context_synchronously

import 'package:afisha/logic/app_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/filter_provider.dart';
import 'package:afisha/ui/screens/main_screen/screen_logic/main_screen_provider.dart';
import 'package:afisha/ui/screens/main_screen/widgets/filter_sheet/styles_filter_sheet.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ActionHandlers {
  //-------
  // Нажатие на кнопку-иконку с сердечком (FavIcon) у события
  static onFavIconButtonTap(BuildContext context, bool isFavorite, String eventId) {
    final appProv = Provider.of<AppProvider>(context, listen: false);
    if (isFavorite) {
      appProv.deleteEventFromFavList(eventId);
    } else {
      appProv.addEventToFavList(eventId);
    }
  }

  //-------
  // Получение списка событий
  static Future<void> getAllEvents(BuildContext context) async {
    final appProv = Provider.of<AppProvider>(context, listen: false);
    appProv.getAllEvents();
  }

  //-------
  // Фильтр: выбор страны
  static onCountrySelect(BuildContext context, String? value) {
    final filterProv = Provider.of<FilterProvider>(context, listen: false);
    final appProv = Provider.of<AppProvider>(context, listen: false);
    filterProv.setSelectedCountry(value);
    appProv.setFilterParams(filterProv.getFilterParams());
  }

  //-------
  // Фильтр: выбор города
  static onCitySelect(BuildContext context, String? value) {
    final filterProv = Provider.of<FilterProvider>(context, listen: false);
    final appProv = Provider.of<AppProvider>(context, listen: false);
    filterProv.setSelectedCity(value);
    appProv.setFilterParams(filterProv.getFilterParams());
  }

  //-------
  // Фильтр: выбор дат
  static Future<void> onDatesFieldTap(BuildContext context) async {
    var dates = await showCalendarDatePicker2Dialog(
      context: context,
      config: getCalendarConfig(context),
      dialogSize: const Size(320, 0),
      value: [],
      borderRadius: BorderRadius.circular(15),
    );
    if (dates == null) return;
    final filterProv = Provider.of<FilterProvider>(context, listen: false);
    final appProv = Provider.of<AppProvider>(context, listen: false);
    if (dates.length == 1) {
      filterProv.setDates(dates[0]!, dates[0]!.add(const Duration(seconds: 24 * 60 * 60 - 1)));
      appProv.setFilterParams(filterProv.getFilterParams());
      return;
    }
    if (dates.length == 2) {
      filterProv.setDates(dates[0]!, dates[1]!.add(const Duration(seconds: 24 * 60 * 60 - 1)));
      appProv.setFilterParams(filterProv.getFilterParams());
      return;
    }
  }

  //-------
  // Фильтр: нажатие на кнопку-иконку "X" (сброс параметров фильтра)
  static onCancelFilterTap(BuildContext context) {
    final filterProv = Provider.of<FilterProvider>(context, listen: false);
    final appProv = Provider.of<AppProvider>(context, listen: false);
    final mainScrProv = Provider.of<MainScreenProvider>(context, listen: false);
    if (appProv.filterParams == null) {
      mainScrProv.setFilterSheetVisibility(false);
    }
    filterProv.clearAllFields();
    appProv.setFilterParams(null);
  }
}
