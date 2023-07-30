import 'package:afisha/=common=/utils.dart';
import 'package:flutter/material.dart';

const kTextFieldSearchBorderRadius = 10.0;

InputDecoration getTextFieldSearchDecoration(BuildContext context) {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: lighten(Theme.of(context).colorScheme.primary, 30),
    contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldSearchBorderRadius)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldSearchBorderRadius)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldSearchBorderRadius)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldSearchBorderRadius)),
    ),
  );
}

TextStyle getTextFieldSearchTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 16.5,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}
