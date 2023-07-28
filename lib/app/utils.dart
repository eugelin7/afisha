import 'dart:math';

String mapInfo(Map<String, dynamic> map) {
  String str = '';
  map.forEach(
      (k, v) => str = '$str $k = ${v.toString().substring(0, min(70, v.toString().length))} \n');
  return str;
}
