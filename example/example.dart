import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_seo/flutter_seo.dart';
import 'package:flutter_seo/src/create_html.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteObserver<PageRoute<dynamic>> routeObserver = SeoRouteObserver();

  @override
  void initState() {
    BodyTagUtil.init();
    addMetaTag();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HeadTagUtil.setTitle("flutter_seo title");
        addCustomTag();
        CreateHtml.makeWidgetTree(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              key: SeoKey(TagType.div, className: "colum class"),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "header text h1",
                  key: SeoKey(
                    TagType.h1,
                    text: "header text h1",
                  ),
                ),
                Text(
                  "header text h2",
                  key: SeoKey(
                    TagType.h2,
                    text: "header text h2",
                  ),
                ),
                Column(
                  key: SeoKey(TagType.div),
                  children: [
                    Text(
                      "Check 1",
                      key: SeoKey(TagType.p),
                    ),
                    Text(
                      "Check 2",
                      key: SeoKey(TagType.p),
                    ),
                  ],
                ),
                Column(
                  key: SeoKey(TagType.div),
                  children: [
                    Text(
                      "Check 3",
                      key: SeoKey(TagType.p),
                    ),
                    Row(
                      key: SeoKey(TagType.div),
                      children: [
                        Text(
                          "Check 4",
                          key: SeoKey(TagType.p),
                        ),
                        Text(
                          "Check 8",
                          key: SeoKey(TagType.p),
                        ),
                        SizedBox(
                          key: SeoKey(TagType.div),
                          child: Stack(
                            key: SeoKey(TagType.div),
                            children: [
                              Text(
                                "Check 9",
                                key: SeoKey(TagType.p),
                              ),
                              Text(
                                "Check 10",
                                key: SeoKey(TagType.p),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  key: SeoKey(TagType.div),
                  children: [
                    Text(
                      "Check 5",
                      key: SeoKey(TagType.p),
                    ),
                    Text(
                      "Check 6",
                      key: SeoKey(TagType.p),
                    ),
                  ],
                ),
                Text(
                  "Check P",
                  key: SeoKey(TagType.p),
                ),
                Container(
                  key: SeoKey(TagType.a, src: "a 태그 확인"),
                  child: Text(
                    "Check String a tag",
                    key: SeoKey(TagType.p),
                  ),
                ),
                SizedBox(
                  key: SeoKey(TagType.a, src: "assets/company_device.png"),
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    key: SeoKey(
                      TagType.img,
                      src: "assets/company_device.png",
                      alt: "로컬 이미지",
                    ),
                    "assets/company_device.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  key: SeoKey(
                    TagType.a,
                    src:
                        "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                  ),
                  width: 200,
                  height: 200,
                  child: Image.network(
                    key: SeoKey(TagType.img,
                        src:
                            "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                        alt: "네트워크 이미지"),
                    "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createHtml(List<ElementModel> elements) {
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

  void addMetaTag() {
    HeadTagUtil.setHead(
      title: "Check title",
      keywords: ["111", "222", "333", "444"],
      description: "Check description",
      imageUrl:
          "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
      url: "https://sailing-it.com",
    );
  }

  void addCustomTag() {
    String custom = '''
    <div>
        <p>aaa</p>
        <p>bbb</p>
        <div>
            <p>ccc</p>
            <p>ddd</p>
        </div>
    </div>''';
    BodyTagUtil.addTag(TagH1(custom));
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

class ElementModel {
  int depth;
  html.Element element;

  ElementModel(this.depth, this.element);

  @override
  String toString() {
    return '\nElementModel{depth: $depth, element: $element}';
  }
}
