import 'package:flutter/material.dart';
import 'package:flutter_seo/flutter_seo.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final RouteObserver<PageRoute<dynamic>> routeObserver = SeoRouteObserver();

  @override
  Widget build(BuildContext context) {
    BodyTagUtil.init();
    addMetaTag();
    return MaterialApp(
      navigatorObservers: [routeObserver],
      title: '',
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
    HeadTagUtil.add("name", "theme-color", "#FFFFFF");
    HeadTagUtil.add("name", "keywords", "IT, Flutter");
  }
}
