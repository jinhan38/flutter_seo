
## Features

You can use the flutter_seo package to add tags to your html, which you can use to try SEO optimization.

On the site made with the sample below, you can see that meta data is added to the head and html tag is created on the body.

 https://seo-package-sample.web.app/


Available tags : h1, h2, h3, h4, h5, h6, p, img, a, header, footer, title, custom tag


## Usage

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
  final RouteObserver<PageRoute<dynamic>> routeObserver = SeoRouteObserver();

  @override
  void initState() {
    BodyTagUtil.init();
    addMetaTag();
    addCustomTag();
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        HeadTagUtil.setTitle("flutter_seo title");
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      BodyTagUtil.updates();
                    },
                    child: const Text("Body HTML Update ")),
                const Text("header text h1").seoHeader(TagType.h1),
                const Text("header text h2").seoHeader(TagType.h2),
                const Text("Check 1").seoH1,
                const Text("Check 2").seoH2,
                const Text("Check 3").seoH3,
                const Text("Check 4").seoH4,
                const Text("Check 5").seoH5,
                const Text("Check 6").seoH6,
                const Text("Check P").seoP,
                const Text("Check String a tag").seoTextWithA(
                    "Check String a tag",
                    TagType.p.name,
                    "https://sailing-it.com",
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
                      "https://sailing-it.com"),
                ),
                const Text("footer text P").seoFooter(TagType.p),
                const Text("footer text H2").seoFooter(TagType.h5),
              ],
            ),
          ),
        ),
      ),
    );
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
    var custom = '''
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

```
