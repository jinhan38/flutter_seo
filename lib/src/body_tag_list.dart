abstract class ParentTag {
  String text;
  String tag;

  ParentTag(this.text, this.tag);

  String changeToHtml() {
    if (this is TagImgWithA) {
      var tag = this as TagImgWithA;
      String titleAttribute =
          tag.title.isNotEmpty ? 'title="${tag.title}"' : '';
      return '<a href="${tag.href}" $titleAttribute><${tag.tag} src="${tag.url}" alt="${tag.alt}" /></a>';
    }

    if (this is TagImg) {
      var tag = this as TagImg;
      return '<${tag.tag} src="${tag.url}" alt="${tag.alt}" />';
    }

    if (this is TagTextWithA) {
      var tag = this as TagTextWithA;
      String titleAttribute =
          tag.title.isNotEmpty ? 'title="${tag.title}"' : '';
      return '<a href="${tag.href}" $titleAttribute><${tag.tag} style="color:black;">$text</${tag.tag}></a>';
    }
    return '<$tag style="color:black;">$text</$tag>';
  }

  @override
  String toString() {
    if (this is TagImg) {
      return '<$tag src="$text" alt="${(this as TagImg).alt}" />';
    }
    return '<$tag style="color:black;">$text</$tag>';
  }
}

class TagImg extends ParentTag {
  String alt;
  String url;

  TagImg(this.url, this.alt) : super('', 'img');
}

class TagImgWithA extends ParentTag {
  String alt;
  String href;
  String url;
  String title;

  TagImgWithA(this.url, this.alt, this.href, this.title) : super('', 'img');
}

class TagTextWithA extends ParentTag {
  String href;
  String title;

  TagTextWithA(super.text, super.tag, this.href, this.title);
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
