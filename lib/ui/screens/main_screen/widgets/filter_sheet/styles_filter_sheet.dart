import 'package:afisha/app/theme/app_theme.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

const kDropDownIconSize = 24.0;
const kFieldTitleWidth = 75.0;

TextStyle? getHintTextStyle(BuildContext context) => context.theme.textTheme.labelLarge?.copyWith(
      color: context.theme.colorScheme.onPrimary.withOpacity(0.65),
      fontStyle: FontStyle.italic,
    );

TextStyle? getTextStyle(BuildContext context) => context.theme.textTheme.labelLarge?.copyWith(
      color: context.theme.colorScheme.onPrimary,
    );

InputDecoration getInputDecoration(BuildContext context) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: context.theme.colorScheme.onPrimary.withOpacity(0.7), width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
  );
}

InputDecoration getInputDecorationDisabled(BuildContext context) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: context.theme.colorScheme.onPrimary.withOpacity(0.25), width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
  );
}

CalendarDatePicker2WithActionButtonsConfig getCalendarConfig(BuildContext context) {
  return CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.range,
    gapBetweenCalendarAndButtons: 10,
    okButton: Row(
      children: [
        Text(
          ' OK ',
          style: TextStyle(
              color: context.theme.colorScheme.primary, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}
