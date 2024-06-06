import 'package:flutter_seo/src/body_tag_util.dart';

abstract class ParentTag {
  String text;
  String tag;

  ParentTag(this.text, this.tag);

  String changeToHtml() {
    if (this is TagHeader) {
      return (this as TagHeader).childTag.changeToHtml();
    }
    if (this is TagFooter) {
      return (this as TagFooter).childTag.changeToHtml();
    }
    if (this is TagImgWithA) {
      var tag = this as TagImgWithA;
      String titleAttribute =
          tag.title.isNotEmpty ? 'title="${tag.title}"' : '';
      return '<a href="${tag.href}" $titleAttribute><img src="${tag.src}" alt="${tag.alt}" /></a>';
    }

    if (this is TagImg) {
      var tag = this as TagImg;
      return '<${tag.tag} src="${tag.src}" alt="${tag.alt}" />';
    }

    if (this is TagTextWithA) {
      var tag = this as TagTextWithA;
      String titleAttribute =
          tag.title.isNotEmpty ? 'title="${tag.title}"' : '';
      return '<a href="${tag.href}" $titleAttribute><${tag.childTag} style="color:black;">$text</${tag.childTag}></a>';
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
  String src;
  String alt;

  TagImg(this.src, this.alt) : super('', TagType.img.name);
}

class TagImgWithA extends ParentTag {
  String alt;
  String href;
  String src;
  String title;

  TagImgWithA(this.src, this.alt, this.href, this.title)
      : super('', TagType.a.name);
}

class TagTextWithA extends ParentTag {
  String href;
  String title;
  final String childTag = TagType.p.name;

  TagTextWithA(String text, this.href, this.title)
      : super(text, TagType.a.name);
}

class TagP extends ParentTag {
  TagP(String text) : super(text, TagType.p.name);
}

class TagH1 extends ParentTag {
  TagH1(String text) : super(text, TagType.h1.name);
}

class TagH2 extends ParentTag {
  TagH2(String text) : super(text, TagType.h2.name);
}

class TagH3 extends ParentTag {
  TagH3(String text) : super(text, TagType.h3.name);
}

class TagH4 extends ParentTag {
  TagH4(String text) : super(text, TagType.h4.name);
}

class TagH5 extends ParentTag {
  TagH5(String text) : super(text, TagType.h5.name);
}

class TagH6 extends ParentTag {
  TagH6(String text) : super(text, TagType.h6.name);
}

class TagHeader extends ParentTag {
  ParentTag childTag;

  TagHeader(this.childTag) : super('', BodyTagUtil.header);
}

class TagFooter extends ParentTag {
  ParentTag childTag;

  TagFooter(this.childTag) : super('', BodyTagUtil.footer);
}
