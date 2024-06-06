import 'dart:html';

import 'allow_uri_policy.dart';

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

  static void setHead({
    String title = "",
    String description = "",
    List<String> keywords = const [],
    String imageUrl = "",
    String url = "",
    String themeColor = "#FFFFFF",
  }) {
    if (themeColor.isNotEmpty) {
      HeadTagUtil.add("name", "theme-color", themeColor);
    }
    if (keywords.isNotEmpty) {
      HeadTagUtil.add("name", "keywords", keywords.join(", "));
    }

    if (title.isNotEmpty) {
      HeadTagUtil.add("property", "og:title", title);
      HeadTagUtil.add("name", "twitter:title", title);
      HeadTagUtil.add("name", "apple-mobile-web-app-title", title);
    }

    if (imageUrl.isNotEmpty) {
      HeadTagUtil.add("property", "og:image", imageUrl);
      HeadTagUtil.add("name", "twitter:card", imageUrl);
      HeadTagUtil.add("name", "twitter:image", imageUrl);
    }

    if (url.isNotEmpty) {
      HeadTagUtil.add("property", "og:url", url);
    }

    if (description.isNotEmpty) {
      HeadTagUtil.add("name", "twitter:description", description);
      HeadTagUtil.add("property", "og:description", description);
      HeadTagUtil.add("name", "description", description);
    }

    HeadTagUtil.add("name", "apple-mobile-web-app-capable", "yes");
    HeadTagUtil.add("name", "apple-mobile-web-app-status-bar-style", "black");
    HeadTagUtil.add(
        "name", "viewport", "width=device-width, initial-scale=1.0");
    HeadTagUtil.add("name", "robots", "index, follow");
  }
}
