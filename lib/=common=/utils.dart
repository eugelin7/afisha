import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'dart:math';

final _unescaper = HtmlUnescape();

//-----
String? jsonStringValue(dynamic json) {
  if (json == null) return null;
  return _unescaper.convert(json.toString());
}

//-----
String mapInfo(Map<String, dynamic> map) {
  String str = '';
  map.forEach(
      (k, v) => str = '$str $k = ${v.toString().substring(0, min(70, v.toString().length))} \n');
  return str;
}

//-----
// Darken a color by [percent] amount (100 = black)
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(), (c.blue * f).round());
}

// Lighten a color by [percent] amount (100 = white)
Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(c.alpha, c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(), c.blue + ((255 - c.blue) * p).round());
}

//-----

