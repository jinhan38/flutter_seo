import 'allow_uri_policy.dart';
import 'dart:html';

class HeadTagUtil {
  static final _headValidator = NodeValidatorBuilder()
    ..allowHtml5(uriPolicy: AllowAllUriPolicy())
    ..allowCustomElement(
      'meta',
      attributes: [
        'name',
        'http-equiv',
        'content',
      ],
    )
    ..allowCustomElement(
      'link',
      attributes: [
        'title',
        'rel',
        'type',
        'hreflang',
        'href',
        'media',
      ],
    );

  static void add(String key, String value, String content) {
    final head = document.head;
    if (head == null) return;

    head.children.removeWhere(
      (element) => element.attributes.containsValue(value),
    );

    var headTag = '<meta $key="$value" content="$content">';
    head.insertAdjacentHtml(
      'beforeEnd',
      headTag,
      validator: _headValidator,
    );
  }
}
