import 'dart:html';

import '../uri_policy/allow_uri_policy.dart';

class HeadTagUtil {
  static final _headValidator = NodeValidatorBuilder()
    ..allowHtml5(uriPolicy: AllowAllUriPolicy())
    ..allowElement("title")
    ..allowElement("div")
    ..allowCustomElement(
      'meta',
      attributes: [
        'name',
        'http-equiv',
        'content',
        'property',
      ],
    );

  /// 타이틀은 머티리얼 앱이 초기화 된 후에 입력 가능
  static void setTitle(String title) {
    document.title = title;
  }

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

  static void removeByValue(String value) {
    final head = document.head;
    if (head == null) return;
    head.children.removeWhere(
      (element) => element.attributes.containsValue(value),
    );
  }

  static void setHead({
    String title = "",
    String description = "",
    List<String> keywords = const [],
    String imageUrl = "",
    String url = "",
    String themeColor = "#FFFFFF",
  }) {
    if (themeColor.isNotEmpty) {
      add("name", "theme-color", themeColor);
    }
    if (keywords.isNotEmpty) {
      add("name", "keywords", keywords.join(", "));
    }

    if (title.isNotEmpty) {
      add("property", "og:title", title);
      add("name", "twitter:title", title);
      add("name", "apple-mobile-web-app-title", title);
    }

    if (imageUrl.isNotEmpty) {
      add("property", "og:image", imageUrl);
      add("name", "twitter:card", imageUrl);
      add("name", "twitter:image", imageUrl);
    }

    if (url.isNotEmpty) {
      add("property", "og:url", url);
    }

    if (description.isNotEmpty) {
      add("name", "twitter:description", description);
      add("property", "og:description", description);
      add("name", "description", description);
    }

    add("name", "apple-mobile-web-app-capable", "yes");
    add("name", "apple-mobile-web-app-status-bar-style", "black");
    add("name", "viewport", "width=device-width, initial-scale=1.0");
    add("name", "robots", "index, follow");
  }
}
