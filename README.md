## Features

You can use the flutter_seo package to add tags to your html, which you can use to try SEO
optimization.

On the site made with the sample below, you can see that meta data is added to the head and html tag
is created on the body.

https://seo-package-sample.web.app/


## Usage

1. Add Head Tag  

If you want to add a description tag, please refer to below.  

- <meta name="description" content="Add description">  
- <meta name="description" content="Add description">

```dart
  @override
void initState() {
  WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
      HeadTagUtil.add("name", "description", "Add description");
      HeadTagUtil.add("property", "og:url", "Add og:url");
    },
  );
  super.initState();
}
```
        

2. Add head Title

> HeadTagUtil.setTitle("titleName");


3. If you want to add several pre-defined tags, follow along 

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
              

4. Add body tag

In order to add body tags, you must add the desired SeoKey to the widget.
Then call `CreateHtml.makeWidgetTree(context)` when the widget is drawn
```dart

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
      key: SeoKey(TagType.div),
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
            key: SeoKey(TagType.p, text: "second"),
          ),
        ],
      ),
    );
  }
}

```
                       


5. Use Navigator's then to draw html again after pop.

```dart
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
```

## Example

Follow the example below to add tags.
to `/example` folder.
      
```dart
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      keywords: [
        "flutter_seo",
        "flutter",
        "flutter element",
        "flutter web seo"
      ],
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
            key: SeoKey(TagType.div),
            children: [
              SizedBox(
                key: SeoKey(TagType.nav),
                child: Row(
                  key: SeoKey(TagType.ul),
                  children: [
                    ElevatedButton(
                      key: SeoKey(TagType.li),
                      onPressed: () {
                        movePage(context, const SecondScreen(), "FirstScreen");
                      },
                      child: Text(
                          key: SeoKey(TagType.a,
                              src: '#secondScreen', text: "secondScreen"),
                          "go secondScreen"),
                    ),
                  ],
                ),
              ),
              Column(
                key: SeoKey(
                  TagType.div,
                  attributes: const {"customStyle": "custom attributes"},
                ),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Text("Check P", key: SeoKey(TagType.p)),
                  Container(
                    key: SeoKey(
                      TagType.a,
                      src: "a tag",
                      text: "Check String a tag",
                    ),
                    child: Text("Check String a tag", key: SeoKey(TagType.p)),
                  ),
                  SizedBox(
                    key: SeoKey(TagType.a,
                        src: "assets/company_device.png", text: "Local image"),
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
              Column(
                key: SeoKey(TagType.footer),
                children: [
                  Text("Check 5", key: SeoKey(TagType.p)),
                  Text("Check 6", key: SeoKey(TagType.p)),
                ],
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
      key: SeoKey(TagType.div),
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
            key: SeoKey(TagType.p, text: "second"),
          ),
          ElevatedButton(
              onPressed: () {
                HeadTagUtil.removeByValue("robots");
              },
              child: const Text("Remove head")) ,
          ElevatedButton(
              onPressed: () {
                HeadTagUtil.add("name", "description", "Update description");
              },
              child: const Text("Change Head")) ,
        ],
      ),
    );
  }
}

```