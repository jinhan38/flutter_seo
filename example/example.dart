import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_seo/flutter_seo.dart';

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

  List<HtmlModel> htmlWidgets = [];

  @override
  void initState() {
    BodyTagUtil.init();
    addMetaTag();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HeadTagUtil.setTitle("flutter_seo title");
        addCustomTag();
        Future.delayed(const Duration(milliseconds: 300), () {
          htmlWidgets.clear();
          final element = _key.currentContext as Element;
          printWidgetTree(element);
        });
      },
    );
    super.initState();
  }

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        key: _key,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("header text h1").seoHeader(TagType.h1),
                const Text("header text h2").seoHeader(TagType.h2),
                Column(
                  children: [
                    const Text("Check 1").seoH1,
                    const Text("Check 2").seoH2,
                  ],
                ),
                Column(
                  children: [
                    const Text("Check 3").seoH3,
                    const Text("Check 4").seoH4,
                  ],
                ),
                Column(
                  children: [
                    const Text("Check 5").seoH5,
                    const Text("Check 6").seoH6,
                  ],
                ),
                const Text("Check P").seoP,
                const Text("Check String a tag").seoTextWithA(
                    "Check String a tag", "https://sailing-it.com",
                    title: "homepage"),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    "assets/company_device.png",
                    fit: BoxFit.cover,
                  ).seoImg(
                    "assets/company_device.png",
                    "our company device logo image",
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(
                    "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                    fit: BoxFit.cover,
                  ).seoImgWithA(
                      "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                      "logo image",
                      "https://sailing-it.com",
                      title: "img title"),
                ),
                const Text("footer text P").seoFooter(TagType.p),
                const Text("footer text H2").seoFooter(TagType.h5),
                ElevatedButton(
                  onPressed: () {
                    print(htmlWidgets);
                    List<ElementModel> eList = [];
                    Set<int> depthSet = {};
                    for (var w in htmlWidgets) {
                      depthSet.add(w.depth);
                    }
                    print('dl : ${depthSet.length}');
                    var dynamicList = createDynamicList(depthSet.length);
                    List<int> depthCount = depthSet.toList();
                    depthCount.sort();
                    for (var w in htmlWidgets) {
                      int flag = 0;
                      for (var d in depthCount) {
                        if(d == w.depth) {
                          // dynamicList[flag]
                        }
                        flag++;
                      }
                    }

                    print("dynamicList : $dynamicList"); // 출력: [[]]
                    eList.add(ElementModel(0, html.DivElement()));
                    for (var w in htmlWidgets) {
                      if (w.widget is Text || w.widget is Image) {
                        for (var e in eList) {
                          if (e.depth == (w.depth - 1)) {
                            if (w.widget is Text) {
                              e.element.append(
                                  _createParagraph((w.widget as Text).data!));
                            } else if (w.widget is Image) {
                              // (w.widget as Image).
                            }
                          }
                        }
                      } else {
                        if(eList.length == 1) {
                          eList.first.element.append( html.DivElement());
                        }
                        eList.add(ElementModel(w.depth, html.DivElement()));
                      }
                    }
                    for (var e in eList) {
                      print('e : ${e.element}');
                      print('e children : ${e.element.children}');
                      html.document.body!.append(e.element);
                    }
                    print(eList);
                  },
                  child: Text("eeeeeee"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dynamic createDynamicList(int depth) {
    if (depth <= 0) {
      return <String>[];
    } else {
      return [createDynamicList(depth - 1)];
    }
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

  void printWidgetTree(Element element, [int depth = 0]) {
    final indent = ' ' * depth;
    if (element.widget is Scaffold ||
        element.widget is Row ||
        element.widget is Column ||
        element.widget is SingleChildScrollView ||
        element.widget is Container ||
        element.widget is SizedBox ||
        element.widget is Image ||
        element.widget is ButtonStyleButton ||
        element.widget is Text) {
      htmlWidgets.add(HtmlModel(depth, element.widget));
    }
    // debugPrint('$indent${element.widget}');
    // if(element.widget is Text) {
    //   print('text 위젯 : ${(element.widget as Text).data}');
    // }
    element.visitChildren((child) {
      printWidgetTree(child, depth + 1);
    });
  }

  // 텍스트를 p 태그로 변환하는 헬퍼 메서드
  html.ParagraphElement _createParagraph(String text) {
    final p = html.ParagraphElement();
    p.text = text;
    // p.style.fontSize = "${fontSize}em";
    // p.style.margin = "0";
    return p;
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
