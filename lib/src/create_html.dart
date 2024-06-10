import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../flutter_seo.dart';

class CreateHtml {
  static final List<HtmlModel> _htmlWidgets = [];

  static void makeWidgetTree(
    BuildContext context,
  ) {
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
    element.visitChildren((child) {
      _setWidgetTree(child, depth + 1);
    });
  }

  static void _createHtml(List<ElementModel> elements) {
    _htmlWidgets.clear();
    if (elements.isEmpty) return;

    // 루트 요소 초기화
    html.Element root = elements[0].element;
    Map<int, html.Element> depthMap = {elements[0].depth: root};

    for (var i = 1; i < elements.length; i++) {
      var currentElement = elements[i];
      var currentDepth = currentElement.depth;

      // 가장 가까운 부모 요소 찾기
      html.Element? parent;
      for (var depth = currentDepth - 1; depth >= 0; depth--) {
        if (depthMap.containsKey(depth)) {
          parent = depthMap[depth];
          break;
        }
      }

      if (parent != null) {
        // 현재 요소를 부모 요소에 추가
        parent.append(currentElement.element);

        // 현재 요소를 depthMap에 추가
        depthMap[currentDepth] = currentElement.element;
      }
    }

    // 루트 요소를 body에 추가
    html.document.body!.append(root);
  }

  // 텍스트를 p 태그로 변환하는 헬퍼 메서드
  static html.ParagraphElement _createParagraph(String text) {
    final p = html.ParagraphElement();
    p.text = text;
    return p;
  }

  static html.HtmlElement _setElement(Widget widget) {
    if (widget.key is SeoKey) {
      var key = widget.key as SeoKey;
      html.HtmlElement element = html.DivElement();
      if (key.tagType == TagType.div) {
        element = html.DivElement()..className = 'content-section';
      } else if (key.tagType == TagType.h1) {
        element = html.HeadingElement.h1()
          ..text = key.text
          ..className;
      } else if (key.tagType == TagType.h2) {
        element = html.HeadingElement.h2()..text = key.text;
      } else if (key.tagType == TagType.h3) {
        element = html.HeadingElement.h3()..text = key.text;
      } else if (key.tagType == TagType.h4) {
        element = html.HeadingElement.h4()..text = key.text;
      } else if (key.tagType == TagType.h5) {
        element = html.HeadingElement.h5()..text = key.text;
      } else if (key.tagType == TagType.h6) {
        element = html.HeadingElement.h6()..text = key.text;
      } else if (key.tagType == TagType.p && widget is Text) {
        element = _createParagraph(widget.data!);
      } else if (key.tagType == TagType.img && widget is Image) {
        element = html.ImageElement(src: key.src)..alt = key.alt;
      } else if (key.tagType == TagType.a) {
        element = html.AnchorElement(href: key.src);
      }
      if (key.className.isNotEmpty) {
        element.className = key.className;
      }
      return element;
    }
    return html.DivElement();
  }
}

class ElementModel {
  int depth;
  html.Element element;

  ElementModel(this.depth, this.element);

  @override
  String toString() {
    return '\nElementModel{depth: $depth, element: $element}';
  }
}

class HtmlModel {
  int depth;
  Widget widget;

  HtmlModel(this.depth, this.widget);

  @override
  String toString() {
    return 'HtmlModel{depth: $depth, widget: $widget}';
  }
}

class SeoKey extends ValueKey<String> {
  final TagType tagType;

  /// image일 때 url
  final String src;
  final String alt;
  final String text;
  final String className;

  SeoKey(
    this.tagType, {
    this.text = "",
    this.src = "",
    this.alt = "",
    this.className = "",
  }) : super("${tagType.name}/random${random.nextInt(9999)}");

  @override
  String toString() {
    return 'SeoKey{tagType: $tagType, src: $src, alt: $alt}';
  }
}
