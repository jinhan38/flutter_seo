import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'flutter_seo.dart';

class CreateHtml {
  static final List<HtmlModel> _htmlWidgets = [];

  static void makeWidgetTree(BuildContext context) {
    _htmlWidgets.clear();
    final element = context as Element;
    _setWidgetTree(element);

    List<ElementModel> elementList = _htmlWidgets
        .map((e) => ElementModel(e.depth, _setElement(e.widget)))
        .toList();

    _createHtml(elementList);
  }

  static void _setWidgetTree(Element element, [int depth = 0]) {
    if (element.widget.key is SeoKey) {
      _htmlWidgets.add(HtmlModel(depth, element.widget));
    }
    element.visitChildren((child) => _setWidgetTree(child, depth + 1));
  }

  static void _createHtml(List<ElementModel> elements) {
    _htmlWidgets.clear();
    if (elements.isEmpty) return;

    html.Element root = elements[0].element;
    Map<int, html.Element> depthMap = {elements[0].depth: root};

    for (var i = 1; i < elements.length; i++) {
      var currentElement = elements[i];
      var currentDepth = currentElement.depth;

      html.Element? parent;
      for (var depth = currentDepth - 1; depth >= 0; depth--) {
        if (depthMap.containsKey(depth)) {
          parent = depthMap[depth];
          break;
        }
      }

      if (parent != null) {
        parent.append(currentElement.element);
        depthMap[currentDepth] = currentElement.element;
      }
    }

    var mainTag = html.document.body!.children.firstWhere(
      (e) => e.localName == BodyTagUtil.mainTag,
    );
    mainTag.append(root);
  }

  static html.HtmlElement _setElement(Widget widget) {
    if (widget.key is SeoKey) {
      var key = widget.key as SeoKey;
      html.HtmlElement element = html.DivElement();
      if (key.tagType == TagType.div) {
        element = html.DivElement()..attributes = key.attributes;
      } else if (key.tagType == TagType.h1) {
        element = html.HeadingElement.h1()
          ..attributes = key.attributes
          ..text = key.text
          ..className;
      } else if (key.tagType == TagType.h2) {
        element = html.HeadingElement.h2()
          ..attributes = key.attributes
          ..text = key.text;
      } else if (key.tagType == TagType.h3) {
        element = html.HeadingElement.h3()
          ..attributes = key.attributes
          ..text = key.text;
      } else if (key.tagType == TagType.h4) {
        element = html.HeadingElement.h4()
          ..attributes = key.attributes
          ..text = key.text;
      } else if (key.tagType == TagType.h5) {
        element = html.HeadingElement.h5()
          ..attributes = key.attributes
          ..text = key.text;
      } else if (key.tagType == TagType.h6) {
        element = html.HeadingElement.h6()
          ..attributes = key.attributes
          ..text = key.text;
      } else if (key.tagType == TagType.p && widget is Text) {
        element = html.ParagraphElement()
          ..attributes = key.attributes
          ..text = widget.data!;
      } else if (key.tagType == TagType.img && widget is Image) {
        element = html.ImageElement()
          ..attributes = key.attributes
          ..alt = key.alt
          ..src = key.src;
      } else if (key.tagType == TagType.a) {
        element = html.AnchorElement()
          ..attributes = key.attributes
          ..href = key.src;
      }
      if (key.className.isNotEmpty) {
        element.className = key.className;
      }
      return element;
    }
    return html.DivElement();
  }
}
