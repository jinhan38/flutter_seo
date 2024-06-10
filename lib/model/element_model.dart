import 'dart:html' as html;

class ElementModel {
  int depth;
  html.Element element;

  ElementModel(this.depth, this.element);

  @override
  String toString() {
    return '\nElementModel{depth: $depth, element: $element}';
  }
}