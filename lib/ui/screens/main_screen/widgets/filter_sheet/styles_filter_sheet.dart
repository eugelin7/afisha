import 'package:flutter/material.dart';

const kDropDownIconSize = 24.0;
const kFieldTitleWidth = 75.0;

TextStyle? getHintTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75),
          fontStyle: FontStyle.italic,
        );

TextStyle? getTextStyle(BuildContext context) => Theme.of(context).textTheme.labelLarge?.copyWith(
      color: Theme.of(context).colorScheme.onPrimary,
    );

InputDecoration getInputDecoration(BuildContext context) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7), width: 1),
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
          BorderSide(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.25), width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
  );
}
