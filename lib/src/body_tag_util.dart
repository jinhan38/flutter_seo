import 'dart:html';

import 'package:flutter/material.dart';

import 'allow_uri_policy.dart';
import 'body_tag_list.dart';

class BodyTagUtil {
  static String myTag = 'flutter-seo';

  static final _bodyValidator = NodeValidatorBuilder()
    ..allowHtml5(uriPolicy: AllowAllUriPolicy())
    ..allowCustomElement(myTag)
    ..allowCustomElement('h1', attributes: ['style'])
    ..allowCustomElement('h2', attributes: ['style'])
    ..allowCustomElement('h3', attributes: ['style'])
    ..allowCustomElement('h4', attributes: ['style'])
    ..allowCustomElement('h5', attributes: ['style'])
    ..allowCustomElement('h6', attributes: ['style'])
    ..allowCustomElement('p', attributes: ['style'])
    ..allowCustomElement('img', attributes: ['alt', 'src'])
    ..allowCustomElement('a', attributes: ['href', 'title']);

  static void init() {
    if (document.body == null) return;
    var isEmpty = document.body!.children
        .where((element) => element.localName == myTag)
        .isEmpty;
    if (!isEmpty) clear();
    document.body?.insertAdjacentHtml(
      'afterBegin',
      '<$myTag></$myTag>',
      validator: _bodyValidator,
    );
  }

  static void clear() {
    document.body?.children
        .removeWhere((element) => element.localName == myTag);
  }

  static Widget add(Widget child, ParentTag parentTag) {
    var myElement = document.body!.children
        .where((element) => element.localName == myTag)
        .where((element) => element.children.every((e) =>
            checkTagType(e.localName, e.text.toString()).changeToHtml() !=
            parentTag.changeToHtml()))
        .toList();

    if (myElement.isEmpty) return child;
    myElement.first.insertAdjacentHtml('beforeend', parentTag.changeToHtml(),
        validator: _bodyValidator);
    return child;
  }

  static void update() {
    var body = document.body!;

    String tagStringList = body.children
        .where((element) => element.localName == myTag)
        .toList()
        .expand((tag) => tag.children)
        .map((child) =>
            checkTagType(child.localName, child.text.toString()).changeToHtml())
        .join();

    body.children.removeWhere((element) => element.localName == myTag);

    body.insertAdjacentHtml(
      'afterBegin',
      '<$myTag>$tagStringList</$myTag>',
      validator: _bodyValidator,
    );
  }

  static ParentTag checkTagType(String localName, String text) {
    switch (localName) {
      case 'p':
        return TagP(text);
      case 'h1':
        return TagH1(text);
      case 'h2':
        return TagH2(text);
      case 'h3':
        return TagH3(text);
      case 'h4':
        return TagH4(text);
      case 'h5':
        return TagH5(text);
      case 'h6':
        return TagH6(text);
    }
    return TagP(text);
  }
}

extension FlutteSeo on Text {
  Text get seoP => BodyTagUtil.add(this, TagP(data!)) as Text;

  Text get seoH1 => BodyTagUtil.add(this, TagH1(data!)) as Text;

  Text get seoH2 => BodyTagUtil.add(this, TagH2(data!)) as Text;

  Text get seoH3 => BodyTagUtil.add(this, TagH3(data!)) as Text;

  Text get seoH4 => BodyTagUtil.add(this, TagH4(data!)) as Text;

  Text get seoH5 => BodyTagUtil.add(this, TagH5(data!)) as Text;

  Text get seoH6 => BodyTagUtil.add(this, TagH6(data!)) as Text;
}

extension FlutterSeo on Widget {
  Widget seoImg(String url, String alt) =>
      BodyTagUtil.add(this, TagImg(url, alt));

  Widget seoImgWithA(
    String url,
    String alt,
    String href, {
    String title = "",
  }) =>
      BodyTagUtil.add(this, TagImgWithA(url, alt, href, title));

  Widget seoTextWithA(
    String text,
    String tag,
    String href, {
    String title = "",
  }) =>
      BodyTagUtil.add(this, TagTextWithA(text, tag, href, title));
}
