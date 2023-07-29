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
