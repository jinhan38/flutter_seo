import 'dart:html';

import 'package:flutter/material.dart';

import 'allow_uri_policy.dart';
import 'body_tag_list.dart';

class BodyTagUtil {
  static String mainTag = 'main';
  static String header = 'header';
  static String footer = 'footer';

  static final _bodyValidator = NodeValidatorBuilder()
    ..allowHtml5(uriPolicy: AllowAllUriPolicy())
    ..allowCustomElement(mainTag)
    ..allowCustomElement(header)
    ..allowCustomElement('h1', attributes: ['style'])
    ..allowCustomElement('h2', attributes: ['style'])
    ..allowCustomElement('h3', attributes: ['style'])
    ..allowCustomElement('h4', attributes: ['style'])
    ..allowCustomElement('h5', attributes: ['style'])
    ..allowCustomElement('h6', attributes: ['style'])
    ..allowCustomElement('p', attributes: ['style'])
    ..allowCustomElement('footer', attributes: ['role'])
    ..allowCustomElement('img', attributes: ['alt', 'src'])
    ..allowCustomElement('a', attributes: ['href', 'title']);

  static void init() {
    if (document.body == null) return;
    var isEmpty = document.body!.children
        .where((element) => element.localName == mainTag)
        .isEmpty;
    if (!isEmpty) clear();
    document.body?.insertAdjacentHtml(
      'afterBegin',
      '<$footer></$footer>',
      validator: _bodyValidator,
    );
    document.body?.insertAdjacentHtml(
      'afterBegin',
      '<$mainTag></$mainTag>',
      validator: _bodyValidator,
    );
    document.body?.insertAdjacentHtml(
      'afterBegin',
      '<$header></$header>',
      validator: _bodyValidator,
    );
  }

  static void clear() {
    document.body?.children.removeWhere((element) =>
        element.localName == mainTag ||
        element.localName == header ||
        element.localName == footer);
  }

  static Widget add(Widget child, ParentTag parentTag) {
    String checkTag = mainTag;
    if (parentTag is TagHeader) {
      checkTag = header;
    }
    if (parentTag is TagFooter) {
      checkTag = footer;
    }
    var myElement = document.body!.children
        .where((element) => element.localName == checkTag)
        .where((element) => element.children.every((e) =>
            checkTagType(e.localName, e.text.toString()).changeToHtml() !=
            parentTag.changeToHtml()))
        .toList();

    if (myElement.isEmpty) return child;
    myElement.first.insertAdjacentHtml('beforeend', parentTag.changeToHtml(),
        validator: _bodyValidator);
    return child;
  }

  static void updates() {
    _update(footer);
    _update(mainTag);
    _update(header);
  }

  static void _update(String tag) {
    var body = document.body!;
    String mainTagList = body.children
        .where((element) => element.localName == tag)
        .toList()
        .expand((tag) => tag.children)
        .map((child) =>
            checkTagType(child.localName, child.text.toString()).changeToHtml())
        .join();

    body.children.removeWhere((element) => element.localName == tag);

    body.insertAdjacentHtml(
      'afterBegin',
      '<$tag>$mainTagList</$tag>',
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

enum TagType { p, h1, h2, h3, h4, h5, h6, a, img, footer }

extension FlutteSeo on Text {
  Text get seoP => BodyTagUtil.add(this, TagP(data!)) as Text;

  Text get seoH1 => BodyTagUtil.add(this, TagH1(data!)) as Text;

  Text get seoH2 => BodyTagUtil.add(this, TagH2(data!)) as Text;

  Text get seoH3 => BodyTagUtil.add(this, TagH3(data!)) as Text;

  Text get seoH4 => BodyTagUtil.add(this, TagH4(data!)) as Text;

  Text get seoH5 => BodyTagUtil.add(this, TagH5(data!)) as Text;

  Text get seoH6 => BodyTagUtil.add(this, TagH6(data!)) as Text;

  Text seoHeader(TagType tagType) {
    late ParentTag childTag;
    if (tagType == TagType.h1) {
      childTag = TagH1(data!);
    } else if (tagType == TagType.h2) {
      childTag = TagH2(data!);
    } else if (tagType == TagType.h3) {
      childTag = TagH3(data!);
    } else if (tagType == TagType.h4) {
      childTag = TagH4(data!);
    } else if (tagType == TagType.h5) {
      childTag = TagH5(data!);
    } else if (tagType == TagType.h6) {
      childTag = TagH6(data!);
    } else {
      childTag = TagP(data!);
    }
    return BodyTagUtil.add(this, TagHeader(childTag)) as Text;
  }

  Text seoFooter(TagType tagType) {
    late ParentTag childTag;
    if (tagType == TagType.h1) {
      childTag = TagH1(data!);
    } else if (tagType == TagType.h2) {
      childTag = TagH2(data!);
    } else if (tagType == TagType.h3) {
      childTag = TagH3(data!);
    } else if (tagType == TagType.h4) {
      childTag = TagH4(data!);
    } else if (tagType == TagType.h5) {
      childTag = TagH5(data!);
    } else if (tagType == TagType.h6) {
      childTag = TagH6(data!);
    } else {
      childTag = TagP(data!);
    }
    return BodyTagUtil.add(this, TagFooter(childTag)) as Text;
  }
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
