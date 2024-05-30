abstract class ParentTag {
  String tag;
  String text;

  ParentTag(this.text, this.tag);

  String changeToHtml() {
    return '<$tag style="color:black;">$text</$tag>';
  }

  @override
  String toString() {
    return '<$tag style="color:black;">$text</$tag>';
  }
}

class TagP extends ParentTag {
  TagP(String text) : super(text, 'p');
}

class TagH1 extends ParentTag {
  TagH1(String text) : super(text, 'h1');
}

class TagH2 extends ParentTag {
  TagH2(String text) : super(text, 'h2');
}

class TagH3 extends ParentTag {
  TagH3(String text) : super(text, 'h3');
}

class TagH4 extends ParentTag {
  TagH4(String text) : super(text, 'h4');
}

class TagH5 extends ParentTag {
  TagH5(String text) : super(text, 'h5');
}

class TagH6 extends ParentTag {
  TagH6(String text) : super(text, 'h6');
}
