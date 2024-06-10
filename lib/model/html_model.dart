import 'package:flutter/material.dart';

class HtmlModel {
  int depth;
  Widget widget;

  HtmlModel(this.depth, this.widget);

  @override
  String toString() {
    return 'HtmlModel{depth: $depth, widget: $widget}';
  }
}
