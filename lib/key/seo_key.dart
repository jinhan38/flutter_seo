import 'dart:math';

import 'package:flutter/material.dart';

import '../flutter_seo.dart';

class SeoKey extends ValueKey<String> {
  final TagType tagType;

  /// image일 때 url
  final String src;
  final String alt;
  final String text;
  final String className;
  final Map<String, String> attributes;

  SeoKey(
    this.tagType, {
    this.text = "",
    this.src = "",
    this.alt = "",
    String? className,
    Map<String, String>? attributes,
  })  : attributes = attributes ??
            (tagType == TagType.p ? const {"style": "color:black;"} : {}),
  className = className ?? (tagType == TagType.div ? 'content-section' : ""),
        super("${tagType.name}/random${_random.nextInt(9999)}");

  @override
  String toString() {
    return 'SeoKey{tagType: $tagType, src: $src, alt: $alt, text: $text, className: $className, attributes: $attributes}';
  }
}
final Random _random = Random();
