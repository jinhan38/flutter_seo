## Features

You can use the flutter_seo package to add tags to your html, which you can use to try SEO
optimization.

On the site made with the sample below, you can see that meta data is added to the head and html tag
is created on the body.

https://seo-package-sample.web.app/


## Usage

1. Add Observer. You have to add SeoRouteObserver in navigatorObservers of MaterialApp.

```dart

final RouteObserver<PageRoute<dynamic>> routeObserver = SeoRouteObserver();

@override
Widget build(BuildContext context) {
  return MaterialApp(
    navigatorObservers: [routeObserver],
  );
}
```

2. You must call BodyTagUtil.init().

```dart
@override
void initState() {
  BodyTagUtil.init();
  super.initState();
}
```

3. Add Metatags using HeadTagUtil. Note that setTitle must be called after MaterialApp is built to take effect.

```dart
void addMetaTag() {
  WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
      HeadTagUtil.setTitle("flutter_seo title");
    },
  );
  HeadTagUtil.add("name", "keywords", "flutter, web, seo");
  HeadTagUtil.setHead(
    title: "Check title",
    keywords: ["111", "222", "333", "444"],
    description: "Check description",
    imageUrl:
    "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
    url: "https://sailing-it.com",
  );
}
```

4. Custom Tag

```dart
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
```

## Example

Follow the example below to add tags.
to `/example` folder.

```dartimport 'package:flutter/material.dart';
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

  @override
  void initState() {
    BodyTagUtil.init();
    addMetaTag();
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
      home: const FirstScreen(),
    );
  }

  void addMetaTag() {
    HeadTagUtil.setHead(
      title: "Check title",
      keywords: ["flutter_seo", "flutter", "flutter element", "flutter web seo"],
      description: "Check description",
      imageUrl:
          "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
      url: "https://sailing-it.com",
    );
  }
}

void movePage(BuildContext context, Widget widget, String currentTitle) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  ).then(
    (value) {
      HeadTagUtil.setTitle(currentTitle);
      CreateHtml.makeWidgetTree(context);
    },
  );
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HeadTagUtil.setTitle("FirstScreen");
        CreateHtml.makeWidgetTree(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            key: SeoKey(
              TagType.div,
              attributes: const {"customStyle": "custom attributes"},
            ),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  movePage(context, const SecondScreen(), "flutter_seo title");
                },
                child: const Text("btn"),
              ),
              Text(
                "header text h1",
                key: SeoKey(TagType.h1, text: "header text h1"),
              ),
              Text(
                "header text h2",
                key: SeoKey(TagType.h2, text: "header text h2"),
              ),
              Column(
                key: SeoKey(TagType.div),
                children: [
                  Text("Check 1", key: SeoKey(TagType.p)),
                  Text("Check 2", key: SeoKey(TagType.p)),
                ],
              ),
              Column(
                key: SeoKey(TagType.div),
                children: [
                  Text("Check 3", key: SeoKey(TagType.p)),
                  Row(
                    key: SeoKey(TagType.div),
                    children: [
                      Text("Check 4", key: SeoKey(TagType.p)),
                      Text("Check 8", key: SeoKey(TagType.p)),
                      SizedBox(
                        key: SeoKey(TagType.div),
                        child: Stack(
                          key: SeoKey(TagType.div),
                          children: [
                            Text("Check 9", key: SeoKey(TagType.p)),
                            Text("Check 10", key: SeoKey(TagType.p)),
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
                  Text("Check 5", key: SeoKey(TagType.p)),
                  Text("Check 6", key: SeoKey(TagType.p)),
                ],
              ),
              Text("Check P", key: SeoKey(TagType.p)),
              Container(
                key: SeoKey(TagType.a, src: "a tag"),
                child: Text("Check String a tag", key: SeoKey(TagType.p)),
              ),
              SizedBox(
                key: SeoKey(TagType.a, src: "assets/company_device.png"),
                width: 200,
                height: 200,
                child: Image.asset(
                  key: SeoKey(
                    TagType.img,
                    src: "assets/company_device.png",
                    alt: "Local image",
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
                  key: SeoKey(
                    TagType.img,
                    src:
                        "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                    alt: "Network Image",
                  ),
                  "https://sailing-it-images.s3.ap-northeast-2.amazonaws.com/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HeadTagUtil.setTitle("SecondScreen");
        CreateHtml.makeWidgetTree(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Column(
        children: [
          Container(
            key: SeoKey(TagType.div),
          ),
          Text(
            "second",
            key: SeoKey(TagType.p),
          ),
        ],
      ),
    );
  }
}

```
