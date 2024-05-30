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

    addMetaTag();
    BodyTagUtil.init();

    return MaterialApp(
      navigatorObservers: [routeObserver],
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  BodyTagUtil.update();
                },
                child: const Text("Body HTML Update ")),
            const Text("Check 1").seoH1,
            const Text("Check 2").seoH2,
            const Text("Check 3").seoH3,
            const Text("Check 4").seoH4,
            const Text("Check 5").seoH5,
            const Text("Check 6").seoH6,
            const Text("Check P").seoP,
          ],
        ),
      ),
    );
  }

  void addMetaTag() {
    HeadTagUtil.add("name", "theme-color", "#FFFFFF");
    HeadTagUtil.add("name", "keywords", "IT, Flutter");
  }
}
