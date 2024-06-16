import 'dart:html';

import '../uri_policy/allow_uri_policy.dart';

class BodyTagUtil {
  static String mainTag = 'main';
  static String header = 'header';
  static String footer = 'footer';
  static String nav = 'nav';

  static final bodyValidator = NodeValidatorBuilder()
    ..allowHtml5(uriPolicy: AllowAllUriPolicy())
    ..allowCustomElement(footer)
    ..allowCustomElement(nav)
    ..allowCustomElement(mainTag);

  static void init() {
    if (document.body == null) return;
    clear();

    document.body?.insertAdjacentHtml(
      'afterBegin',
      '<$mainTag></$mainTag>',
      validator: bodyValidator,
    );
  }

  static void clear() {
    document.body?.children
        .removeWhere((element) => element.localName == mainTag);
  }
}
