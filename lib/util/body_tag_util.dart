import 'dart:html';

import '../uri_policy/allow_uri_policy.dart';

class BodyTagUtil {
  static String mainTag = 'main';
  static String header = 'header';
  static String footer = 'footer';

  static final _bodyValidator = NodeValidatorBuilder()
    ..allowHtml5(uriPolicy: AllowAllUriPolicy())
    ..allowCustomElement(mainTag);

  // ..allowCustomElement(header)
  // ..allowCustomElement('div', attributes: ['style'])
  // ..allowCustomElement('h1', attributes: ['style'])
  // ..allowCustomElement('h2', attributes: ['style'])
  // ..allowCustomElement('h3', attributes: ['style'])
  // ..allowCustomElement('h4', attributes: ['style'])
  // ..allowCustomElement('h5', attributes: ['style'])
  // ..allowCustomElement('h6', attributes: ['style'])
  // ..allowCustomElement('p', attributes: ['style'])
  // ..allowCustomElement('footer', attributes: ['role'])
  // ..allowCustomElement('img', attributes: ['alt', 'src'])
  // ..allowCustomElement('a', attributes: ['href', 'title']);

  static void init() {
    if (document.body == null) return;
    clear();

    document.body?.insertAdjacentHtml(
      'afterBegin',
      '<$mainTag></$mainTag>',
      validator: _bodyValidator,
    );
  }

  static void clear() {
    document.body?.children
        .removeWhere((element) => element.localName == mainTag);
  }
}
