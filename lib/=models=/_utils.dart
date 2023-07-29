import 'package:html_unescape/html_unescape.dart';

final _unescaper = HtmlUnescape();

String? jsonStringValue(dynamic json) {
  if (json == null) return null;
  return _unescaper.convert(json.toString());
}
